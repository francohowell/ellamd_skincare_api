module TransactionScripts
  module Subscription
    class UpdateCard
      attr_reader :subscription, :stripe_token, :error

      delegate :stripe_customer, to: :subscription

      def initialize(subscription:, stripe_token: nil)
        @subscription = subscription
        @stripe_token = stripe_token
      end

      def run
        if stripe_token.blank?
          @error = "Card token is blank"
          return false
        end

        subscription.update_card(stripe_token: stripe_token)
        true
      end
    end
  end
end
