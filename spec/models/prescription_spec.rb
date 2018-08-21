# == Schema Information
#
# Table name: prescriptions
#
#  id                        :integer          not null, primary key
#  physician_id              :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  token                     :string
#  signa                     :text             default(""), not null
#  customer_instructions     :text             default(""), not null
#  pharmacist_instructions   :text             default(""), not null
#  tracking_number           :text
#  fragrance                 :string
#  cream_base                :string
#  volume_in_ml              :integer          default(15), not null
#  formulation_id            :integer
#  fulfilled_at              :datetime
#  visit_id                  :integer
#  not_downloaded_alerted_at :datetime
#  no_tracking_alerted_at    :datetime
#  is_copy                   :boolean          default(FALSE), not null
#

require "rails_helper"

describe Prescription do
  let (:prescription) { prescriptions(:ben_raspail_previous_visit_prescription) }

  context "with different statuses" do
    before do
      visit = visits(:ben_raspail_previous_visit)

      @incoming   = FactoryBot.create(:prescription, visit: visit)
      @processing = FactoryBot.create(:prescription, visit: visit, fulfilled_at: $now)
      @filled     = FactoryBot.create(:prescription, visit: visit, fulfilled_at: $now, tracking_number: "123")

      @prescriptions = Prescription.where(id: [@incoming, @processing, @filled])
    end

    describe ".incoming" do
      it "returns only incoming Prescriptions" do
        expect(@prescriptions.incoming).to contain_exactly(@incoming)
      end
    end

    describe ".processing" do
      it "returns only processing Prescriptions" do
        expect(@prescriptions.processing).to contain_exactly(@processing)
      end
    end

    describe ".filled" do
      it "returns only filled Prescriptions" do
        expect(@prescriptions.filled).to contain_exactly(@filled)
      end
    end
  end

  describe "#build_copy" do
    it "builds deep copy of given Prescription" do
      result = prescription.build_copy

      expect(result.customer_instructions).to eq("herp derp")
      expect(result.prescription_ingredients.length).to eq(1)
    end
  end
end
