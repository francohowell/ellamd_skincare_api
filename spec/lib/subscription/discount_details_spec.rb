require "rails_helper"

describe "Subscription::DiscountDetails" do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  describe "as_json" do
    it "renders Subscription Discount details as hash object ready to be converted to json" do
      ben_raspail_subscription.stripe_coupon_id = "PAUSED-SUBSCRIPTION-DO-NOT-DELETE"

      details = Subscription::DiscountDetails.new(ben_raspail_subscription)

      VCR.use_cassette "Subscription::DiscountDetails active" do
        expect(details.as_json[:coupon]).to be_present
      end
    end

    it "works when Subscription is not associated with Stripe Coupon yet" do
      details = Subscription::DiscountDetails.new(ben_raspail_subscription)

      VCR.use_cassette "Subscription::DiscountDetails nil" do
        expect(details.as_json[:coupon]).to be_nil
      end
    end
  end
end
