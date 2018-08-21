# == Schema Information
#
# Table name: products
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  store             :integer          not null
#  origin_id         :integer
#  image_url         :string
#  product_url       :string
#  description       :text
#  diagnoses         :text
#  instructions      :text
#  tags              :jsonb
#  packages          :jsonb
#  average_rating    :float
#  number_of_reviews :integer
#  raw               :jsonb
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  brand             :string
#  store_id          :string
#  is_pending        :boolean          default(FALSE), not null
#

require "rails_helper"

describe Product do
  let(:ellamd_formulation) { products(:ellamd_formulation) }
  let(:good_genes_acid_treatment) { products(:good_genes_acid_treatment) }

  describe "validations" do
    it "is valid and saveable with valid attributes" do
      product = FactoryBot.build(:product)

      expect(product).to be_valid
      expect(product.save).to be_truthy
    end
  end

  describe "#eligible_for_update?" do
    it "returns true if Product is a new one" do
      product = FactoryBot.build(:product)
      expect(product.eligible_for_update?).to be_truthy
    end

    it "returns true if Product has not been updated for a while" do
      good_genes_acid_treatment.updated_at = Time.parse("2019-12-20")
      expect(good_genes_acid_treatment.eligible_for_update?).to be_truthy
    end

    it "returns false if Product has been updated recently" do
      good_genes_acid_treatment.updated_at = Time.parse("2019-12-31")
      expect(good_genes_acid_treatment.eligible_for_update?).to be_falsey
    end
  end

  describe "#raw" do
    it "returns empty hash when Raw is null" do
      expect(ellamd_formulation.raw).to eq({})
    end
  end

  describe "ingredients_string=" do
    it "parses comma-or-newline-separated string and adds ProductIngredients to the Product" do
      ellamd_formulation.ingredients_string = "Water,Glycerin\nCitric Acid"
      ellamd_formulation.save!

      result = ellamd_formulation.product_ingredients.map(&:name)
      expected = ["Water", "Glycerin", "Citric Acid"]
      expect(result).to contain_exactly(*expected)
    end
  end
end
