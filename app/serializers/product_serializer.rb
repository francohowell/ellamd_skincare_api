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

class ProductSerializer < ApplicationSerializer
  # Attributes not included in the list:
  # -  origin_id
  # -  raw
  attribute :id
  attribute :store_id
  attribute :store
  attribute :brand
  attribute :name

  attribute :description
  attribute :diagnoses
  attribute :instructions

  attribute :image_url
  attribute :product_url

  attribute :tags
  attribute :packages

  attribute :average_rating
  attribute :number_of_reviews

  attribute :is_pending

  attribute :created_at
  attribute :updated_at

  has_many :product_ingredients
  always_include :product_ingredients
end
