require 'rails_helper'

describe Subscription::Blocker do
  let(:ben_raspail_subscription) { subscriptions(:ben_raspail_subscription) }

  let(:ben_raspail_current_visit) { visits(:ben_raspail_current_visit) }
  let(:ben_raspail_previous_visit_prescription) { prescriptions(:ben_raspail_previous_visit_prescription) }

  describe "#exists?" do
    before do
      prescription = ben_raspail_previous_visit_prescription.build_copy
      prescription.visit = ben_raspail_current_visit
      prescription.save!
    end

    it "returns false if Subscription is not blocked based on previous Prescription" do
      blocker = Subscription::Blocker.new(ben_raspail_subscription)
      expect(blocker.exists?).to be_falsey
    end

    it "returns true if Subscription is blocked based on previous Prescription" do
      blocker = Subscription::Blocker.new(ben_raspail_subscription)
      ben_raspail_subscription.customer.medical_profile.sex = "female"

      expect(blocker.exists?).to be_truthy
    end
  end
end
