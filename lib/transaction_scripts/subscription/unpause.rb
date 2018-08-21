module TransactionScripts
  module Subscription
    class Unpause
      attr_reader :subscription, :medical_profile_params, :error

      delegate :customer,        to: :subscription
      delegate :medical_profile, to: :customer

      def initialize(subscription:, medical_profile_params:)
        @subscription           = subscription
        @medical_profile_params = medical_profile_params
      end

      def run
        unless subscription.paused?
          @error = "Subscription is not paused"
          return false
        end

        medical_profile.update_attributes!(medical_profile_params)

        if medical_profile.previous_changes.present?
          customer.current_visit.prescription&.destroy!
        end

        subscription.unpause
        true
      end
    end
  end
end
