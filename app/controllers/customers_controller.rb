# rubocop:disable Metrics/ClassLength
class CustomersController < ApplicationController
  before_action :set_customer_from_params, only: [
    :update,
    :update_phone,
    :archive,
    :create_visit
  ]

  ONBOARDING_STEP_COUNT = 4

  def index
    authorize! :read, Customer

    customers = Customer.includes(:identity, :photos, visits: :prescription)

    if params[:actions_required]
      customers = customers.needs_prescription
    elsif params[:with_messages]
      customers = customers.with_messages
    else
      customers = customers.page(params[:page])
    end

    render json: {
      "customers" => customers.map { |customer| V2::CustomerSerializer.new(customer, mode: :basic).as_json },
      "meta"      => pagination_meta(customers)
    }
  end

  def show
    authorize! :read, Customer

    @customer = Customer.includes(
      :identity,
      :subscription,
      :medical_profile,
      actual_regimen: {regimen_products: {product: :product_ingredients}},
      photos: [:annotations, :photo_conditions],
      physician: :identity,
      visits: [
        photos: :annotations,
        diagnosis: [:conditions, physician: :identity],
        prescription: [:ingredients, physician: :identity, formulation: :ingredients],
        regimen: {regimen_products: {product: :product_ingredients}}
      ]
    ).find(params[:id])

    render json: {
      "customer" => V2::CustomerSerializer.new(@customer, mode: :complete).as_json
    }
  end

  def create
    authorize! :create, Customer

    @customer =
      if params[:provider] == "facebook"
        create_customer_from_facebook
      elsif params[:provider] == "google"
        create_customer_from_google
      else
        create_customer
      end

    # We include the Identity (and, more importantly, a new authorization token for the Identity)
    # so that the UI can refresh its authorization headers.
    render json: @customer.identity, meta: {token: @customer.identity.create_new_auth_token}
  end

  def archive
    authorize! :archive, @customer
    @customer.update!(archived_at: Time.current)
    render json: @customer
  end

  # TODO: move this logic into transaction script
  def update
    authorize! :update, @customer

    Customer.transaction do
      if params[:last_onboarding_step].to_i > ONBOARDING_STEP_COUNT
        @customer.onboarding_completed_at ||= Time.now
      end

      @customer.identity.update!(identity_params)
      @customer.update!(customer_params)
      @customer.medical_profile.update_and_require_new_treatment_plan(medical_profile_params)

      if params[:last_onboarding_step]
        track("Completed onboarding step", {step: params[:last_onboarding_step] - 1}, @customer)

        if params[:last_onboarding_step] > ONBOARDING_STEP_COUNT
          track("Completed entire onboarding form", {}, @customer)
        end
      end
    end

    # If we're in the initial onboarding, the UI sends in the `initial_signup` parameter so we know
    # to do any first-time tasks (like sending emails as we're doing here).
    if params[:initial_signup]
      if @customer.subscription.initial_treatment_plan_is_free?
        UserMailer.send_customer_signup_complete_unpaid_email(@customer)
      else
        UserMailer.send_customer_signup_complete_paid_email(@customer)
      end
    end

    render json: @customer
  end

  ##
  # Update the Customer's phone number and send them a text message about sending in photos.
  #
  # We have a specific endpoint for this because there are phone-number forms in the UI which allow
  # the user to text in photos.
  def update_phone
    authorize! :update, @customer

    @customer.update!(params.permit(:phone))

    if params[:time] == "8am" || params[:time] == "9pm"
      message = "You're scheduled for a text from us at #{params[:time]} so you can send in a " \
        "few closeups for our dermatologist. Feel free to respond to this text with photos if " \
        "you get to it sooner!"

      @customer.send_text_message(message)
      @customer.delay(run_at: time_parameter_to_time(params[:time])).send_photo_prompt_text_message
    else
      @customer.send_photo_prompt_text_message
    end

    render json: @customer
  end

  ##
  # Create a new Visit for the Customer.
  def create_visit
    @customer.visits.create!
    render json: @customer
  end

  ##
  # Convert a time parameter provided by the front end to a Time object.
  private def time_parameter_to_time(time_parameter)
    time = Time.now.in_time_zone("Pacific Time (US & Canada)")

    case time_parameter
    when "8am" then time = time.change(hour: 8)
    when "9pm" then time = time.change(hour: 21)
    end

    time += 1.day if time < Time.current

    time
  end

  ##
  # Pull the profile parameters from the `param` object.
  private def identity_params
    params.permit(
      :first_name,
      :last_name,
      :email
    )
  end

  private def customer_params
    params.permit(
      :address_line_1,
      :address_line_2,
      :zip_code,
      :state,
      :city,
      :phone,
      :last_onboarding_step
    )
  end

  private def medical_profile_params
    (params[:medical_profile] || ActionController::Parameters.new).permit(
      :sex,
      :date_of_birth,
      :is_smoker,
      :is_pregnant,
      :is_breast_feeding,
      :is_on_birth_control,
      :known_allergies,
      :current_prescription_oral_medications,
      :current_prescription_topical_medications,
      :current_nonprescription_topical_medications,
      :past_prescription_oral_medications,
      :past_prescription_topical_medications,
      :past_nonprescription_topical_medications,
      :using_peels,
      :using_retinol,
      :has_been_on_accutane,
      :has_hormonal_issues,
      :other_concerns,
      :preferred_fragrance,
      :skin_type,
      :sunscreen_frequency,
      :sunscreen_brand,
      :user_skin_extra_details,
      skin_concerns: []
    )
  end

  ##
  # Create a Customer from the standard form parameters.
  private def create_customer
    customer = nil

    Customer.transaction do
      customer = Customer.create!(
        # Eventually we'll have more than one Physician. For now, though, the one Physician is sort
        # of like a singleton, and we assign that Physician by default.
        physician: Physician.first,
      )

      Identity.create!(
        params.permit(:first_name, :last_name, :email, :password).merge(user: customer),
      )
    end

    customer
  end

  ##
  # Create a Customer from data from Facebook.
  private def create_customer_from_facebook
    customer = nil
    facebook_user = Facebook.find_user(access_token: params[:facebook_access_token])

    if (identity = Identity.find_by(uid: facebook_user["id"], provider: "facebook"))
      customer = identity.user
    else
      Customer.transaction do
        customer = Customer.create!(physician: Physician.first)

        Identity.create!(
          first_name: facebook_user["first_name"],
          last_name: facebook_user["last_name"],
          email: facebook_user["email"],
          provider: "facebook",
          uid: facebook_user["id"],
          password: Devise.friendly_token.first(10),
          user: customer,
        )
      end
    end

    customer
  end

  ##
  # Create a Customer from Google data.
  private def create_customer_from_google
    customer = nil

    if (identity = Identity.find_by(uid: params[:uid], provider: params[:provider]))
      customer = identity.user
    else
      Customer.transaction do
        customer = Customer.create!(physician: Physician.first)

        Identity.create!(
          first_name: params["first_name"],
          last_name: params["last_name"],
          email: params["email"],
          provider: params["provider"],
          uid: params["uid"],
          password: Devise.friendly_token.first(10),
          user: customer,
        )
      end
    end

    customer
  end
end
