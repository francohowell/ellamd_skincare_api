require "rails_helper"

describe V2::PrescriptionSerializer do
  let(:prescription) { prescriptions(:ben_raspail_previous_visit_prescription) }

  describe "#as_json" do
    it ":basic mode: returns Prescription hash" do
      result = V2::PrescriptionSerializer.new(prescription, mode: :basic).as_json
      expect(result["id"]).to be_present
    end

    it ":complete mode: returns Prescription hash with all bells and whistles" do
      result = V2::PrescriptionSerializer.new(prescription, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["pdf-url"]).to be_present

      expect(result["physician"]).to be_present
      expect(result["formulation"]).to be_present
      expect(result["prescription-ingredients"]).to be_present
    end

    it "returns nil if Prescription is not present" do
      result = V2::PrescriptionSerializer.new(nil, mode: :basic).as_json
      expect(result).to be_nil
    end
  end
end
