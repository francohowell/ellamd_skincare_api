require "rails_helper"

describe V2::MedicalProfileSerializer do
  let(:medical_profile) { medical_profiles(:ben_raspail_medical_profile) }

  describe "#as_json" do
    it ":basic mode: returns MedicalProfile hash" do
      result = V2::MedicalProfileSerializer.new(medical_profile, mode: :basic).as_json
      expect(result["id"]).to be_present
    end

    it ":complete mode: returns MedicalProfile hash" do
      result = V2::MedicalProfileSerializer.new(medical_profile, mode: :complete).as_json
      expect(result["id"]).to be_present
    end
  end
end
