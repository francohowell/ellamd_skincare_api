module TransactionScripts
  module Subscription
    class Cancel
      attr_reader :subscription, :error

      delegate :stripe_customer, to: :subscription

      def initialize(subscription:)
        @subscription = subscription
      end

      def run
        if subscription.inexistent? || subscription.cancelled?
          @error = "Subscription has been already cancelled"
          return false
        end

        subscription.cancel
        true
      end
    end
  end
end
