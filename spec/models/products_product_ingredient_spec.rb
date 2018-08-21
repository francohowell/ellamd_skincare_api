# == Schema Information
#
# Table name: products_product_ingredients
#
#  id                    :integer          not null, primary key
#  product_id            :integer          not null
#  product_ingredient_id :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require "rails_helper"

describe ProductsProductIngredient do
  describe "validations" do
    it "is valid and saveable with valid attributes" do
      product = FactoryBot.create(:product)
      product_ingredient = FactoryBot.create(:product_ingredient)

      ppi = FactoryBot.build(
        :products_product_ingredient,
        product: product,
        product_ingredient: product_ingredient)

      expect(ppi).to be_valid
      expect(ppi.save).to be_truthy
    end
  end
end
