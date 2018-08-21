require "rails_helper"

describe TransactionScripts::Subscription::UpdateCard do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  it "returns true and updates Subscription card" do
    ts = TransactionScripts::Subscription::UpdateCard.new(
      subscription: ben_raspail_subscription,
      stripe_token: "tok_mastercard_debit"
    )

    VCR.use_cassette "TransactionScripts::Subscription::UpdateCard success" do
      expect(ts.run).to be_truthy

      stripe_customer = Stripe::Customer.retrieve(ben_raspail_subscription.stripe_customer_id)
      stripe_source   = stripe_customer.default_source
      stripe_card     = stripe_customer.sources.retrieve(stripe_source)

      expect(stripe_card.last4).to eq("8210")
    end
  end

  it "returns false with error message when :stripe_token is blank" do
    ts = TransactionScripts::Subscription::UpdateCard.new(
      subscription: ben_raspail_subscription,
      stripe_token: ""
    )

    expect(ts.run).to be_falsey
    expect(ts.error).to be_present
  end
end
