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

class Product < ApplicationRecord
  include AlgoliaSearch
  include Duplicatable

  MAX_UPDATE_FREQUENCY = 7.days

  has_many :regimen_products,             inverse_of: :product, dependent: :destroy
  has_many :products_product_ingredients, inverse_of: :product, dependent: :destroy

  has_many :regimens,            through: :regimen_products
  has_many :product_ingredients, through: :products_product_ingredients

  enum store: %i(custom sephora ulta dermstore sokoglam)

  validates :name,  presence: true
  validates :store, presence: true

  scope :pending,         -> { where(is_pending: true) }
  scope :without_pending, -> { where(is_pending: false) }

  algoliasearch auto_index: false, per_environment: true do
    attribute :id
    attribute :brand
    attribute :name

    attribute :productIngredients do
      product_ingredients.map do |pi|
        {
          id:    pi.id,
          name:  pi.name,
          isKey: pi.is_key
        }
      end
    end
  end

  def eligible_for_update?
    new_record? || (updated_at + MAX_UPDATE_FREQUENCY <= Time.now)
  end

  def is_duplicate_of?(another_product)
    another_product && (brand == another_product.brand) && (name == another_product.name)
  end

  def raw
    read_attribute(:raw) || {}
  end

  def ingredients_string=(string)
    self.products_product_ingredients = []

    string.split(",")
          .flat_map { |substring| substring.split("\n") }
          .map(&:strip)
          .select(&:present?)
          .each do |pi_name|
      pi = ProductIngredient.upsert!(name: pi_name)
      products_product_ingredients.build(product_ingredient: pi)
    end
  end

  def update_ingredients!(product_ingredient_names)
    product_ingredient_names.select(&:present?).each do |pi_name|
      pi = ProductIngredient.upsert!(name: pi_name)
      ProductsProductIngredient.upsert!(product_id: id, product_ingredient_id: pi.id)
    end
  end
end
