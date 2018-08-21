require "rails_helper"

describe Subscription::PaymentDetails do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  describe "as_json" do
    it "renders Subscription Payment details as hash object ready to be converted to json" do
      ben_raspail_subscription.stripe_customer_id = "cus_CLiv4zu4CXN22r"
      ben_raspail_subscription.stripe_subscription_id = "sub_CLiva9bg1jfjOq"

      details = Subscription::PaymentDetails.new(ben_raspail_subscription)

      VCR.use_cassette "Subscription::PaymentDetails active" do
        expect(details.as_json[:card]).to be_present
        expect(details.as_json[:previous_invoices]).to be_present
        expect(details.as_json[:upcoming_invoice]).to be_present
      end
    end
  end
end
