require "rails_helper"

describe V2::ProductIngredientSerializer do
  let(:water) { product_ingredients(:water) }

  describe "#as_json" do
    it ":basic mode: returns ProductIngredient hash" do
      result = V2::ProductIngredientSerializer.new(water, mode: :basic).as_json
      expect(result["id"]).to be_present
    end

    it ":complete mode: returns ProductIngredient hash" do
      result = V2::ProductIngredientSerializer.new(water, mode: :complete).as_json
      expect(result["id"]).to be_present
    end
  end
end
