require "rails_helper"

describe StripeEventHandlers::CouponHandler do
  let(:event) { stripe_event("coupon_deleted_1") }

  describe ".call" do
    it "creates new Handler and calls #run on it" do
      expect_any_instance_of(StripeEventHandlers::CouponHandler).to receive(:run).and_call_original
      StripeEventHandlers::CouponHandler.call(event)
    end
  end

  describe "#coupon" do
    it "returns Stripe Coupon object" do
      @handler = StripeEventHandlers::CouponHandler.new(event)
      expect(@handler.send(:coupon)).to be_kind_of(Stripe::Coupon)
    end
  end
end
