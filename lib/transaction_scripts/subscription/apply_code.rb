module TransactionScripts
  module Subscription
    class ApplyCode
      attr_reader :subscription, :code, :error

      def initialize(subscription:, code:)
        @subscription = subscription
        @code = code
      end

      def run
        if code_gives_free_treatment_plan
          give_free_treatment_plan
        else
          apply_stripe_coupon
        end
      end

      private def code_gives_free_treatment_plan
        return code.to_s.upcase == "BIGELLAMDTHANKYOU"
      end

      private def give_free_treatment_plan
        if subscription.initial_treatment_plan_is_free
          @error = "That promotional code has already been applied"
          return false
        end

        unless subscription.inexistent?
          @error = "That promotional code cannot be applied now"
          return false
        end

        visit = subscription.current_visit

        ApplicationRecord.transaction do
          subscription.update_attributes!(initial_treatment_plan_is_free: true)
          visit.update_attributes!(payment_status: :unpaid_with_free_treatment_plan)
        end

        true
      end

      private def apply_stripe_coupon
        if subscription.stripe_coupon_id.present?
          @error = "You have already applied promo code"
          return false
        end

        subscription.apply_coupon(coupon: code)
        true
      rescue Stripe::InvalidRequestError => error
        @error = error.message
        false
      end
    end
  end
end
