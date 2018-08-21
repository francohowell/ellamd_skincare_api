require "rails_helper"

describe V2::FormulationSerializer do
  let(:formulation) { formulations(:against_acne) }

  describe "#as_json" do
    it ":complete mode: returns Formulation hash with FormulationIngredients" do
      result = V2::FormulationSerializer.new(formulation, mode: :complete).as_json

      expect(result["id"]).to be_present
      expect(result["formulation-ingredients"]).to be_present
    end
  end
end
