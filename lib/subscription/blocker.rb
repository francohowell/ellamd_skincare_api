class Subscription
  class Blocker
    attr_reader :subscription

    delegate :customer,        to: :subscription
    delegate :medical_profile, to: :customer

    def initialize(subscription)
      @subscription = subscription
    end

    def exists?
      # Add more blockers here
      female_customer_has_been_prescribed_tretinoin?
    end

    private def last_prescription
      @last_prescription ||= subscription.current_visit&.prescription
    end

    private def female_customer_has_been_prescribed_tretinoin?
      return false unless last_prescription
      return false if medical_profile.sex == "male"

      return last_prescription.ingredients.exists?(name: "Tretinoin")
    end
  end
end
