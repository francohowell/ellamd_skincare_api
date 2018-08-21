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

FactoryBot.define do
  factory :products_product_ingredient do
    # Set product yourself
    # Set product_ingredient yourself
  end
end
