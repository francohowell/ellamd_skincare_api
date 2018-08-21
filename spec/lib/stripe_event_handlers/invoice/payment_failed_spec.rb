require "rails_helper"

describe StripeEventHandlers::Invoice::PaymentFailed do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }
  let(:ben_raspail_current_visit) { visits(:ben_raspail_current_visit) }
  let(:event) { stripe_event("invoice_payment_failed_1") }
  let(:handler) { StripeEventHandlers::Invoice::PaymentFailed.new(event) }

  it "marks Subscription as unpaid and sends mail to the Customer" do
    expect(UserMailer).to receive(:send_email).and_call_original

    ben_raspail_subscription.update_columns(
      stripe_subscription_id: "sub_CJzrCobuq9k8GT",
      status: :active
    )

    VCR.use_cassette "StripeEventHandlers::Invoice::PaymentFailed success" do
      handler.run
    end

    ben_raspail_subscription.reload
    ben_raspail_current_visit.reload

    expect(ben_raspail_current_visit.stripe_invoice_id).to eq("in_000LriDHigVOsSF3WLwtrPy0")
    expect(ben_raspail_subscription.status).to eq("unpaid")
  end
end
