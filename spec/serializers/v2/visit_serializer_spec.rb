require "rails_helper"

describe V2::VisitSerializer do
let(:visit) { visits(:ben_raspail_previous_visit) }

  describe "#as_json" do
    it ":basic mode: returns Visit hash with basic Prescription" do
      result = V2::VisitSerializer.new(visit, mode: :basic).as_json

      expect(result["id"]).to be_present
      expect(result["prescription"]).to be_present
    end

    it ":complete mode: returns Visit hash with Photos, Diagnosis, Prescription and Regimen" do
      result = V2::VisitSerializer.new(visit, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["photos"]).to be_present
      expect(result["diagnosis"]).to be_present
      expect(result["prescription"]).to be_present
      expect(result["regimen"]).to be_present
    end

    it "returns nil if Visit is not present" do
      result = V2::VisitSerializer.new(nil, mode: :basic).as_json
      expect(result).to be_nil
    end
  end
end
