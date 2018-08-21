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

class ProductIngredientSerializer < ApplicationSerializer
  attribute :id
  attribute :name
  attribute :is_key

  attribute :created_at
  attribute :updated_at
end
