module StripeEventHandlers
  module Coupon
    class Deleted < CouponHandler
      def run
        Subscription.where(stripe_coupon_id: coupon.id)
                    .update_all(stripe_coupon_id: nil)
      end
    end
  end
end
