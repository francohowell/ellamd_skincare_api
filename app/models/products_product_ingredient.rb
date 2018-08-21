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

class ProductsProductIngredient < ApplicationRecord
  upsert_keys [:product_id, :product_ingredient_id]

  belongs_to :product,            inverse_of: :products_product_ingredients
  belongs_to :product_ingredient, inverse_of: :products_product_ingredients

  validates :product_id,            presence: true
  validates :product_ingredient_id, presence: true
end
