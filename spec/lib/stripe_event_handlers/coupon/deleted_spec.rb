require "rails_helper"

describe StripeEventHandlers::Coupon::Deleted do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }
  let(:event) { stripe_event("coupon_deleted_1") }
  let(:handler) { StripeEventHandlers::Coupon::Deleted.new(event) }

  it "removes all references to deleted Stripe Coupon from the database" do
    ben_raspail_subscription.update_column(:stripe_coupon_id, "HERP-DERP")
    handler.run

    ben_raspail_subscription.reload
    expect(ben_raspail_subscription.stripe_coupon_id).to be_nil
  end

  it "does not delete references to other Stripe Coupons" do
    ben_raspail_subscription.update_column(:stripe_coupon_id, "HERP-DERP-2")
    handler.run

    ben_raspail_subscription.reload
    expect(ben_raspail_subscription.stripe_coupon_id).to eq("HERP-DERP-2")
  end
end
