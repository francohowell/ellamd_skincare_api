module TransactionScripts
  module Subscription
    class Start
      attr_reader :subscription, :stripe_token, :error

      delegate :stripe_customer, to: :subscription

      def initialize(subscription:, stripe_token: nil)
        @subscription = subscription
        @stripe_token = stripe_token
      end

      def run
        update_customer_card
        start_subscription
      rescue Stripe::CardError, Stripe::InvalidRequestError => error
        @error = error.message
        return false
      end

      private def update_customer_card
        return if stripe_token.blank?
        subscription.update_card(stripe_token: stripe_token)
      end

      private def start_subscription
        if stripe_customer.default_source.blank? && !subscription.initial_treatment_plan_is_free?
          @error = "No payment method"
          return false
        end

        subscription.start
        true
      end
    end
  end
end
