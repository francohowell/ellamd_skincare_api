require "rails_helper"

describe TransactionScripts::Subscription::ApplyCode do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  describe "#code_gives_free_treatment_plan" do
    before do
      @ts = TransactionScripts::Subscription::ApplyCode.new(
        subscription: ben_raspail_subscription,
        code: "BIGELLAMDTHANKYOU"
      )
    end

    it "during onboarding it returns true and gives Customer free treatment plan" do
      expect(@ts.run).to be_truthy

      ben_raspail_subscription.reload
      expect(ben_raspail_subscription.initial_treatment_plan_is_free).to be_truthy
      expect(ben_raspail_subscription.current_visit.payment_status).to eq("unpaid_with_free_treatment_plan")
    end

    it "cannot be applied twice" do
      ben_raspail_subscription.update_column(:initial_treatment_plan_is_free, true)

      expect(@ts.run).to be_falsey
      expect(@ts.error).to be_present
    end

    it "cannot be applied after onboaring" do
      ben_raspail_subscription.update_column(:status, Subscription.statuses[:active])

      expect(@ts.run).to be_falsey
      expect(@ts.error).to be_present
    end
  end

  describe "apply_stripe_coupon" do
    it "returns true and applies stripe coupon to the customer" do
      ts = TransactionScripts::Subscription::ApplyCode.new(
        subscription: ben_raspail_subscription,
        code: "50OFF"
      )

      VCR.use_cassette "TransactionScripts::Subscription::ApplyCode#apply_stripe_coupon success" do
        expect(ts.run).to be_truthy
        expect(ben_raspail_subscription.stripe_coupon_id).to eq("50OFF")
      end
    end

    it "returns false with error when Customer has already applied stripe coupon" do
      ben_raspail_subscription.update_column(:stripe_coupon_id, "Herp-Derp")

      ts = TransactionScripts::Subscription::ApplyCode.new(
        subscription: ben_raspail_subscription,
        code: "does-not-matter"
      )

      expect(ts.run).to be_falsey
      expect(ts.error).to be_present
    end

    it "returns false with error when stripe coupon does not exist" do
      ts = TransactionScripts::Subscription::ApplyCode.new(
        subscription: ben_raspail_subscription,
        code: "does-not-exist-in-stripe"
      )

      VCR.use_cassette "TransactionScripts::Subscription::ApplyCode#apply_stripe_coupon error" do
        expect(ts.run).to be_falsey
        expect(ts.error).to be_present
      end
    end
  end
end
