require "rails_helper"

describe TransactionScripts::Visit::CreateUpcoming do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  it "returns true and creates recurring Visit with Prescription copied from previous Visit" do
    ben_raspail_subscription.update_columns({
      stripe_subscription_id: "sub_CJz1wlRucFhDC9",
      status: Subscription.statuses[:active],
      next_visit_at: Time.now
    })

    ts = TransactionScripts::Visit::CreateUpcoming.new(subscription: ben_raspail_subscription)

    VCR.use_cassette "TransactionScripts::Subscription::CreateUpcoming success" do
      expect {
        expect(ts.run).to be_truthy
      }.to change { Visit.count }.by(1)
    end
  end
end
