require "rails_helper"

describe V2::SubscriptionSerializer do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  describe "#as_json" do
    it ":basic mode: returns Subscription hash" do
      result = V2::SubscriptionSerializer.new(ben_raspail_subscription, mode: :basic).as_json
      expect(result["id"]).to be_present
    end

    it ":complete mode: returns Subscription hash" do
      result = V2::SubscriptionSerializer.new(ben_raspail_subscription, mode: :complete).as_json
      expect(result["id"]).to be_present
    end
  end
end
