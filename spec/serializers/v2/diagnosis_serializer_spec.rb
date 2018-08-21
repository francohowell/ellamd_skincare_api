require "rails_helper"

describe V2::DiagnosisSerializer do
  let(:diagnosis) { diagnoses(:ben_raspail_previous_visit_diagnosis) }

  describe "#as_json" do
    it ":complete mode: returns Diagnosis hash with Physician and DiagnosisConditions" do
      result = V2::DiagnosisSerializer.new(diagnosis, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["physician"]).to be_present
      expect(result["diagnosis-conditions"]).to be_present
    end
  end
end
