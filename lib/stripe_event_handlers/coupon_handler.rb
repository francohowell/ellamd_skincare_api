module StripeEventHandlers
  class CouponHandler
    attr_reader :coupon

    def self.call(event)
      new(event).run
    end

    def initialize(event)
      @coupon = event.data.object
    end

    # No-op, override it in event handler
    def run; end
  end
end
