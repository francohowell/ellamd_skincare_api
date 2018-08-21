# == Schema Information
#
# Table name: ingredients
#
#  id                       :integer          not null, primary key
#  name                     :string           not null
#  minimum_amount           :float            not null
#  maximum_amount           :float            not null
#  unit                     :string           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  description              :text
#  classes                  :string           default([]), not null, is an Array
#  is_premium               :boolean          default(FALSE), not null
#  is_prescription_required :boolean          default(FALSE), not null
#

##
# An Ingredient is a component of a skincare cream.
#
# Some Ingredients are prescription-only medications, while others are additives for the cream. They
# all have a minimum and maximum amount and a unit for that amount (usually a percentage by weight).
class Ingredient < ApplicationRecord
  has_many :formulation_ingredients,  inverse_of: :ingredient
  has_many :prescription_ingredients, inverse_of: :ingredient, dependent: :nullify

  validates :name,           presence: true, uniqueness: true
  validates :minimum_amount, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :maximum_amount, presence: true, numericality: {greater_than_or_equal_to: ->(i) { i.minimum_amount }}
  validates :unit,           presence: true
  validates :description,    presence: true, allow_nil: true
end
