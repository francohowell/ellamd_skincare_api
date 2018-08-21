# == Schema Information
#
# Table name: product_ingredients
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  origin_id  :integer
#  is_key     :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductIngredient < ApplicationRecord
  include Duplicatable

  upsert_keys [:name]

  has_many :products_product_ingredients, inverse_of: :product_ingredient, dependent: :destroy
  has_many :products, through: :products_product_ingredients

  validates :name, presence: true
end
