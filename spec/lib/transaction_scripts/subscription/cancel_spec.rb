require "rails_helper"

describe TransactionScripts::Subscription::Cancel do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  it "returns true and cancels active Subscription" do
    ben_raspail_subscription.update_columns({
      stripe_subscription_id: "sub_CJz1wlRucFhDC9",
      status: Subscription.statuses[:active]
    })

    ts = TransactionScripts::Subscription::Cancel.new(subscription: ben_raspail_subscription)

    VCR.use_cassette "TransactionScripts::Subscription::Cancel success" do
      expect(ts.run).to be_truthy
    end
  end

  it "returns false with error message when inactive Subscription is being cancelled" do
    ts = TransactionScripts::Subscription::Cancel.new(subscription: ben_raspail_subscription)

    expect(ts.run).to be_falsey
    expect(ts.error).to be_present
  end
end
