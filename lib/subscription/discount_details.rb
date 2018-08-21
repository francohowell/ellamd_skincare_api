class Subscription
  class DiscountDetails
    attr_reader :subscription

    def initialize(subscription)
      @subscription = subscription
    end

    def as_json
      load_data

      {
        coupon: @coupon
      }
    end

    private def load_data
      return if @loaded

      @coupon = if subscription.stripe_coupon_id.present?
                  Stripe::Coupon.retrieve(subscription.stripe_coupon_id)
                else
                  nil
                end

      @loaded = true
    end
  end
end
