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

class IngredientSerializer < ApplicationSerializer
  attribute :id
  attributes :name
  attribute :minimum_amount
  attribute :maximum_amount
  attribute :unit
  attribute :description
end
