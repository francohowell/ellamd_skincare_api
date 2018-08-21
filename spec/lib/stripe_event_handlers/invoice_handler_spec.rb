require "rails_helper"

describe StripeEventHandlers::InvoiceHandler do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }
  let(:ben_raspail_current_visit) { visits(:ben_raspail_current_visit) }
  let(:event) { stripe_event("invoice_payment_succeeded_1") }
  let(:handler) { StripeEventHandlers::InvoiceHandler.new(event) }

  describe ".call" do
    it "creates new Handler and calls #run on it" do
      expect_any_instance_of(StripeEventHandlers::InvoiceHandler).to receive(:run).and_call_original
      StripeEventHandlers::InvoiceHandler.call(event)
    end
  end

  describe "eligible?" do
    it "returns true if Subscription and Visit are eligible for payment" do
      ben_raspail_subscription.update_column(:stripe_subscription_id, "sub_CJzrCobuq9k8GT")
      expect(handler.eligible?).to be_truthy
    end

    # TODO: check subscription environment in metadata and raise error
    #       if it matches but cannot be found in the database
    it "return false and logs warn message if Subscription cannot be found" do
      expect(Rails.logger).to receive(:warn)
      expect(handler.eligible?).to be_falsey
    end
  end

  describe "#invoice" do
    it "returns Stripe Invoice object" do
      expect(handler.send(:invoice)).to be_kind_of(Stripe::Invoice)
    end
  end

  describe "#visit" do
    it "returns Subscription's current visit" do
      ben_raspail_subscription.update_column(:stripe_subscription_id, "sub_CJzrCobuq9k8GT")
      expect(handler.send(:visit)).to eq(ben_raspail_current_visit)
    end
  end

  describe "#subscription" do
    it "returns Subscription by given Stripe invoice subscription id" do
      ben_raspail_subscription.update_column(:stripe_subscription_id, "sub_CJzrCobuq9k8GT")
      expect(handler.send(:subscription)).to eq(ben_raspail_subscription)
    end
  end
end
