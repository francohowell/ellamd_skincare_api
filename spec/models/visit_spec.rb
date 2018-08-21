# == Schema Information
#
# Table name: visits
#
#  id                :integer          not null, primary key
#  customer_id       :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  payment_status    :integer          default("unpaid"), not null
#  stripe_invoice_id :string
#

require "rails_helper"

describe Visit do
  let(:ben_raspail) { customers(:ben_raspail) }
  let(:previous_visit) { visits(:ben_raspail_previous_visit) }
  let(:current_visit) { visits(:ben_raspail_current_visit) }

  describe ".without_prescription" do
    it "returns Visits that don't have Prescriptions" do
      result = Visit.where(id: [previous_visit, current_visit]).without_prescription
      expect(result).to contain_exactly(current_visit)
    end
  end

  describe ".can_have_rx" do
    it "returns Visits that can have RX based on payment status" do
      result = Visit.where(id: [previous_visit, current_visit]).can_have_rx
      expect(result).to contain_exactly(previous_visit)
    end
  end

  describe ".waiting_for_rx" do
    it "returns Visits that are currently waiting for RX" do
      paid_visit_without_rx = FactoryBot.create(:visit, customer: ben_raspail, payment_status: :paid)

      result = Visit.where(id: [previous_visit, current_visit, paid_visit_without_rx]).waiting_for_rx
      expect(result).to contain_exactly(paid_visit_without_rx)
    end
  end

  describe "#has_to_be_paid?" do
    it "returns true if and only if Visit has to be paid" do
      expect(current_visit.has_to_be_paid?).to be_truthy
      expect(previous_visit.has_to_be_paid?).to be_falsey
    end
  end

  describe "#already_paid?" do
    it "returns true if and only if Visit does not have to be paid" do
      expect(previous_visit.already_paid?).to be_truthy
      expect(current_visit.already_paid?).to be_falsey
    end
  end

  describe "#previous_visit" do
    it "returns Visit that preceeds given Visit" do
      expect(current_visit.previous_visit).to eq(previous_visit)
      expect(previous_visit.previous_visit).to be_nil
    end
  end
end
