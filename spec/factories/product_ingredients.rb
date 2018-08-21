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

FactoryBot.define do
  factory :product_ingredient do
    name { |n| "ProductIngredient ##{n}" }
    is_key false
  end
end
