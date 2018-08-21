class PrescriptionsController < ApplicationController
  before_action :set_prescription_from_params, only: [:pdf_token, :prescription_pdf, :add_tracking]

  def index
    authorize! :read, Prescription

    @prescriptions = Prescription.eager_load(formulation: {formulation_ingredients: :ingredient},
                                             physician: :identity,
                                             prescription_ingredients: :ingredient,
                                             visit: {customer: :identity})
                                 .where(visits: {payment_status: [1, 2]})
                                 .page(params[:page])

    # TODO: extract to sortable concern
    sort_columns = {
      "name" => "(COALESCE(identities_customers.last_name, '') || COALESCE(identities_customers.first_name, ''))",
      "created-at" => "prescriptions.id"
    }
    sort_column    = sort_columns[params["sort-column"]] || sort_columns["created-at"]
    sort_ascending = if params["sort-ascending"]
                       ActiveRecord::Type::Boolean.new.cast(params["sort-ascending"])
                     else
                       true
                     end

    @prescriptions = @prescriptions.order(Arel.sql("#{sort_column} #{sort_ascending ? 'ASC' : 'DESC'}"))

    case params["filter"]
    when "new"
      @prescriptions = @prescriptions.incoming
    when "processing"
      @prescriptions = @prescriptions.processing
    when "filled"
      @prescriptions = @prescriptions.filled
    end

    render json: @prescriptions, meta: pagination_meta(@prescriptions)
  end

  ##
  # Get action token for allowing pdf download.
  def pdf_token
    authorize! :download, @prescription

    token = ActionToken.create owner: current_identity,
                               tokenable: @prescription
    render json: token
  end

  ##
  # Render and serve a PDF of the request Prescription.
  def prescription_pdf
    token = ActionToken.find_by(token: params[:action_token])

    if token && token.good?(@prescription.id)
      @prescription.mark_as_fulfilled
      token.mark_as_used

      render pdf: @prescription.pdf_filename,
             formats: :html,
             disposition: "attachment"
    else
      render json: {error: 'Invalid token'}
    end
  end

  ##
  # Add tracking information to the Prescription.
  def add_tracking
    authorize! :add_tracking, @prescription

    TransactionScripts::Prescription::AddTracking.new(
      prescription: @prescription,
      tracking_number: params[:tracking_number]
    ).run!

    track("Added tracking to a prescription", prescription_id: @prescription.id)

    render json: @prescription
  end
end
