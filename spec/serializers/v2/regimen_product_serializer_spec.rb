require "rails_helper"

describe V2::RegimenProductSerializer do
  let(:regimen_product) { regimen_products(:ben_raspail_actual_regimen_am_good_genes_acid_treatment) }

  describe "#as_json" do
    it ":complete mode: returns RegimenProduct hash with Product" do
      result = V2::RegimenProductSerializer.new(regimen_product, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["product"]).to be_present
    end
  end
end
