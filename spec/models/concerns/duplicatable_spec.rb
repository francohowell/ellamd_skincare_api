require "rails_helper"

describe Duplicatable do
  let(:vitamin_d) { product_ingredients(:vitamin_d) }
  let(:cholecalciferol) { product_ingredients(:cholecalciferol) }

  describe "associations" do
    it "correctly sets origin/duplicates associations" do
      expect(cholecalciferol.origin).to eq(vitamin_d)
      expect(vitamin_d.duplicates).to contain_exactly(cholecalciferol)
    end
  end

  describe ".without_duplicates" do
    it "returns only non-duplicate records" do
      expect(ProductIngredient.without_duplicates).to include(vitamin_d)
      expect(ProductIngredient.without_duplicates).not_to include(cholecalciferol)
    end
  end

  describe "#original?" do
    it "returns true if and only if Product is original one" do
      expect(vitamin_d.original?).to be_truthy
      expect(cholecalciferol.original?).to be_falsey
    end
  end

  describe "#duplicate?" do
    it "returns true if and only if Product is duplicate one" do
      expect(cholecalciferol.duplicate?).to be_truthy
      expect(vitamin_d.duplicate?).to be_falsey
    end
  end

  describe "#mark_as_origin" do
    it "marks record as origin" do
      expect(cholecalciferol.original?).to be_falsey
      cholecalciferol.mark_as_original
      expect(cholecalciferol.original?).to be_truthy
    end
  end

  describe "#mark_as_duplicate_of" do
    it "marks record as duplicate of another record" do
      another_product_ingredient = FactoryBot.create(:product_ingredient)

      expect(vitamin_d.duplicate?).to be_falsey
      vitamin_d.mark_as_duplicate_of(another_product_ingredient)
      expect(vitamin_d.duplicate?).to be_truthy
    end
  end
end
