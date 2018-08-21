require "rails_helper"

describe SubscriptionsController do
  let(:ben_raspail) { customers(:ben_raspail) }
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  before do
    sign_in(ben_raspail)
  end

  describe "#start" do
    it "starts Subscription and renders it" do
      VCR.use_cassette "SubscriptionsController#start success" do
        delete_stripe_customer_sources_and_subscriptions
        post :start, params: {id: ben_raspail_subscription.id, stripe_token: 'tok_visa'}
      end

      expect(response).to be_successful
      expect(json_response.dig("subscription", "status")).to eq("paused")
      expect(json_response.dig("subscription", "stripe-subscription-id")).to be_present
    end
  end

  private def delete_stripe_customer_sources_and_subscriptions
    ben_raspail_subscription.stripe_customer.subscriptions.each { |s| s.delete }
    ben_raspail_subscription.stripe_customer.sources.each { |s| s.delete }
  end
end
