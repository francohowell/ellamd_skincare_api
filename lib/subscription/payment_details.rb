class Subscription
  class PaymentDetails
    attr_reader :subscription

    def initialize(subscription)
      @subscription = subscription
    end

    def as_json
      load_data

      {
        card: @card,
        previous_invoices: @previous_invoices,
        upcoming_invoice: @upcoming_invoice
      }
    end

    private

    def load_data
      return if @loaded

      stripe_customer = subscription.stripe_customer

      default_source = stripe_customer.default_source
      @card = default_source ? stripe_customer.sources.retrieve(default_source) : nil

      @previous_invoices = stripe_customer.invoices.data
      @upcoming_invoice = stripe_customer.upcoming_invoice

    rescue Stripe::InvalidRequestError => error
      # It means there are no upcoming invoices for this customer, do nothing
    ensure
      @loaded = true
    end
  end
end
