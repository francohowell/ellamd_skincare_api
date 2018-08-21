require "rails_helper"

describe StripeEventHandlers::Invoice::PaymentSucceeded do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }
  let(:ben_raspail_current_visit) { visits(:ben_raspail_current_visit) }
  let(:event) { stripe_event("invoice_payment_succeeded_1") }
  let(:handler) { StripeEventHandlers::Invoice::PaymentSucceeded.new(event) }

  it "marks unpaid Visit as paid one and sends mail to the Customer" do
    ben_raspail_subscription.update_columns(
      status: :active,
      stripe_subscription_id: "sub_CJzrCobuq9k8GT"
    )

    VCR.use_cassette "StripeEventHandlers::Invoice::PaymentSucceeded success" do
      handler.run
    end
    ben_raspail_current_visit.reload

    expect(ben_raspail_current_visit.stripe_invoice_id).to eq("in_1BvLriDHigVOsSF3WLwtrPyi")
    expect(ben_raspail_current_visit.payment_status).to eq("paid")
  end
end
