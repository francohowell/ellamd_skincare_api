require "rails_helper"

describe V2::RegimenSerializer do
  let(:regimen) { regimens(:ben_raspail_actual_regimen) }

  describe "#as_json" do
    it ":complete mode: returns Regimen hash with RegimenProducts" do
      result = V2::RegimenSerializer.new(regimen, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["regimen-products"]).to be_present
    end
  end
end

