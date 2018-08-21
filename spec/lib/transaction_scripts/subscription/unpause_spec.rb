require "rails_helper"

describe TransactionScripts::Subscription::Unpause do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }
  let(:ben_raspail_current_visit) { visits(:ben_raspail_current_visit) }

  context "with paused Subscription and pre-built Prescription" do
    before do
      ben_raspail_subscription.update_columns({
        stripe_subscription_id: "sub_CLpIAJZPx67L77",
        status: Subscription.statuses[:paused]
      })

      prescription = prescriptions(:ben_raspail_previous_visit_prescription)
      prescription.visit = ben_raspail_current_visit
      prescription.save!
    end

    it "returns true, unpauses Subscription and preserves Prescription
          when Customer does not change" do
      ts = TransactionScripts::Subscription::Unpause.new(
        subscription: ben_raspail_subscription,
        medical_profile_params: {has_been_on_accutane: false}
      )

      VCR.use_cassette "TransactionScripts::Subscription::Unpause success" do
        expect(ts.run).to be_truthy
      end

      ben_raspail_subscription.reload
      expect(ben_raspail_subscription.active?).to be_truthy

      ben_raspail_current_visit.reload
      expect(ben_raspail_current_visit.prescription).to be_present
    end

    it "deletes Prescription when Customer has changed" do
      ts = TransactionScripts::Subscription::Unpause.new(
        subscription: ben_raspail_subscription,
        medical_profile_params: {has_been_on_accutane: "my whole life"}
      )

      VCR.use_cassette "TransactionScripts::Subscription::Unpause success" do
        expect(ts.run).to be_truthy
      end

      ben_raspail_subscription.reload
      expect(ben_raspail_subscription.active?).to be_truthy

      ben_raspail_current_visit.reload
      expect(ben_raspail_current_visit.prescription).to be_nil
    end
  end

  it "returns false with error message when non-paused Subscription is being unpaused" do
    ts = TransactionScripts::Subscription::Unpause.new(
      subscription: ben_raspail_subscription,
      medical_profile_params: {has_been_on_accutane: false}
    )

    expect(ts.run).to be_falsey
    expect(ts.error).to be_present
  end
end
