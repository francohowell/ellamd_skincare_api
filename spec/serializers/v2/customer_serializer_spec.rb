require "rails_helper"

describe V2::CustomerSerializer do
  let(:ben_raspail) { customers(:ben_raspail) }

  describe "#as_json" do
    it ":basic mode: returns Customer hash with Visits and Photos" do
      result = V2::CustomerSerializer.new(ben_raspail, mode: :basic).as_json

      expect(result["id"]).to be_present
      expect(result["visits"]).to be_present
      expect(result["photos"]).to be_present
    end

    it ":complete mode: returns Customer hash with all bells and whistles" do
      result = V2::CustomerSerializer.new(ben_raspail, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["visits"]).to be_present
      expect(result["photos"]).to be_present
      expect(result["physician"]).to be_present
      expect(result["subscription"]).to be_present
      expect(result["medical-profile"]).to be_present
      expect(result["actual-regimen"]).to be_present
    end
  end
end
