module V2
  class CustomerSerializer
    attr_reader :customer, :mode

    def initialize(customer, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(basic complete))

      @customer = customer
      @mode     = mode
    end

    def as_json
      return nil if customer.nil?

      case mode
      when :basic    then as_json_basic
      when :complete then as_json_complete
      end
    end

    private def as_json_basic
      {
        "id" => customer.id,
        "physician-id" => customer.physician_id,

        "first-name" => customer.first_name,
        "last-name" => customer.last_name,
        "email" => customer.email,

        "address-line-1" => customer.address_line_1,
        "address-line-2" => customer.address_line_2,
        "zip-code" => customer.zip_code,
        "state" => customer.state,
        "city" => customer.city,
        "phone" => customer.phone&.phony_formatted,

        "created-at" => customer.created_at,
        "onboarding-completed-at" => customer.onboarding_completed_at,
        "updated-at" => customer.updated_at,

        "last-onboarding-step" => customer.last_onboarding_step,

        "photos" => photo_hashes,
        "visits" => visit_hashes,
      }
    end

    private def as_json_complete
      as_json_basic.merge(
        "physician" => V2::PhysicianSerializer.new(customer.physician, mode: mode).as_json,
        "subscription" => V2::SubscriptionSerializer.new(customer.subscription, mode: mode).as_json,
        "medical-profile" => V2::MedicalProfileSerializer.new(customer.medical_profile, mode: mode).as_json,
        "actual-regimen" => V2::RegimenSerializer.new(customer.actual_regimen, mode: mode).as_json,
      )
    end

    private def photo_hashes
      customer.photos
              .map { |photo| V2::PhotoSerializer.new(photo, mode: mode).as_json }
    end

    private def visit_hashes
      customer.visits
              .map { |visit| V2::VisitSerializer.new(visit, mode: mode).as_json }
    end
  end
end
