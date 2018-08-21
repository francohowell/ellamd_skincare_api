module StripeEventHandlers
  class InvoiceHandler
    attr_reader :invoice

    def self.call(event)
      new(event).run
    end

    def initialize(event)
      @invoice = event.data.object
    end

    # No-op, override it in event handler
    def run; end

    def eligible?
      if subscription.nil?
        Rails.logger.warn("Subscription for invoice ##{invoice.id} cannot be found")
        return false
      end

      if invoice.amount_due == 0
        # Subscription has started in "trial" mode and $0 invoice has been issued
        return false
      end

      true
    end

    private def visit
      @visit ||= subscription.current_visit
    end

    private def subscription
      @subscription ||= Subscription.find_by(stripe_subscription_id: invoice.subscription)
    end
  end
end
