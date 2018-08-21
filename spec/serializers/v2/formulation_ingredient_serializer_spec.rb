require "rails_helper"

describe V2::FormulationIngredientSerializer do
  let(:formulation_ingredient) { formulation_ingredients(:against_acne_tretinoin) }

  describe "#as_json" do
    it ":complete mode: returns FormulationIngredient hash with Ingredient" do
      result = V2::FormulationIngredientSerializer.new(formulation_ingredient, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["ingredient"]).to be_present
    end
  end
end
