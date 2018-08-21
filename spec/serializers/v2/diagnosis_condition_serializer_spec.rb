require "rails_helper"

describe V2::DiagnosisConditionSerializer do
  let(:diagnosis_condition) { diagnosis_conditions(:ben_raspail_previous_visit_diagnosis_acne) }

  describe "#as_json" do
    it ":complete mode: returns DiagnosisCondition hash with Condition" do
      result = V2::DiagnosisConditionSerializer.new(diagnosis_condition, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["condition"]).to be_present
    end
  end
end
