require "rails_helper"

describe V2::IngredientSerializer do
  let(:tretinoin) { ingredients(:tretinoin) }

  describe "#as_json" do
    it ":basic mode: returns Ingredient hash" do
      result = V2::IngredientSerializer.new(tretinoin, mode: :basic).as_json
      expect(result["id"]).to be_present
    end

    it ":complete mode: returns Ingredient hash" do
      result = V2::IngredientSerializer.new(tretinoin, mode: :complete).as_json
      expect(result["id"]).to be_present
    end
  end
end
