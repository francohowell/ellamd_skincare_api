require "rails_helper"

describe Questionable do
  let(:medical_profile) { medical_profiles(:ben_raspail_medical_profile) }

  describe "readers and writes" do
    it "correctly handles False value input" do
      medical_profile.update_attributes!(is_pregnant: false)
      medical_profile.reload

      expect(medical_profile.read_attribute(:is_pregnant)).to be_nil
      expect(medical_profile.is_pregnant).to eq(false)
    end

    it "correctly handles True value input(even though it should not happen)" do
      medical_profile.update_attributes!(is_pregnant: true)
      medical_profile.reload

      expect(medical_profile.read_attribute(:is_pregnant)).to eq("")
      expect(medical_profile.is_pregnant).to eq("")
    end

    it "correctly handles String value input" do
      medical_profile.update_attributes!(is_pregnant: "Sixth month")
      medical_profile.reload

      # expect(medical_profile.read_attribute(:is_pregnant)).to eq("Sixth month")
      expect(medical_profile.is_pregnant).to eq("Sixth month")
    end
  end

  describe ".question_with_required_details" do
    it "permits False value" do
      medical_profile.known_allergies = false
      expect(medical_profile).to be_valid
    end

    it "permits non-empty string value" do
      medical_profile.known_allergies = "to cats"
      expect(medical_profile).to be_valid
    end

    it "forbids empty string value" do
      medical_profile.known_allergies = ""

      expect(medical_profile).not_to be_valid
      expect(medical_profile.errors[:known_allergies]).to be_present
    end

    it "forbids True value (even though it should not happen)" do
      medical_profile.known_allergies = true

      expect(medical_profile).not_to be_valid
      expect(medical_profile.errors[:known_allergies]).to be_present
    end
  end
end
