require "rails_helper"

describe V2::ProductSerializer do
  let(:good_genes_acid_treatment) { products(:good_genes_acid_treatment) }

  describe "#as_json" do
    it ":complete mode: returns Product hash with ProductIngredients" do
      result = V2::ProductSerializer.new(good_genes_acid_treatment, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["product-ingredients"]).to be_present
    end
  end
end
