require "rails_helper"

describe V2::PrescriptionIngredientSerializer do
  let(:prescription_ingredient) { prescription_ingredients(:ben_raspail_previous_visit_prescription_tretinoin) }

  describe "#as_json" do
    it ":complete mode: returns PrescriptionIngredient hash with Ingredient" do
      result = V2::PrescriptionIngredientSerializer.new(prescription_ingredient, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["ingredient"]).to be_present
    end
  end
end
