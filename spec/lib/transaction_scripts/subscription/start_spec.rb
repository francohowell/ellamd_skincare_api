require "rails_helper"

describe TransactionScripts::Subscription::Start do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  it "adds payment source and starts Stripe subscription" do
    ts = TransactionScripts::Subscription::Start.new(
      subscription: ben_raspail_subscription,
      stripe_token: "tok_visa"
    )

    VCR.use_cassette "TransactionScripts::Subscription::Start success" do
      delete_stripe_customer_sources_and_subscriptions

      expect(ts.run).to be_truthy
      expect(ben_raspail_subscription.status).to eq("paused")
      expect(ben_raspail_subscription.stripe_subscription_id).to be_present
    end
  end

  it "returns false with error message when Subscription has no payment sources" do
    ts = TransactionScripts::Subscription::Start.new(
      subscription: ben_raspail_subscription,
      stripe_token: ""
    )

    VCR.use_cassette "TransactionScripts::Subscription::Start no payment sources" do
      delete_stripe_customer_sources_and_subscriptions

      expect(ts.run).to be_falsey
      expect(ts.error).to be_present
      expect(ben_raspail_subscription.status).to eq("paused")
    end
  end

  it "returns false with error message when Charge fails" do
    ts = TransactionScripts::Subscription::Start.new(
      subscription: ben_raspail_subscription,
      stripe_token: "tok_chargeDeclined"
    )

    VCR.use_cassette "TransactionScripts::Subscription::Start charge fails" do
      delete_stripe_customer_sources_and_subscriptions

      expect(ts.run).to be_falsey
      expect(ts.error).to be_present
      expect(ben_raspail_subscription.status).to eq("inexistent")
    end
  end

  private def delete_stripe_customer_sources_and_subscriptions
    ben_raspail_subscription.stripe_customer.subscriptions.each { |s| s.delete }
    ben_raspail_subscription.stripe_customer.sources.each { |s| s.delete }
  end
end
