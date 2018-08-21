# == Schema Information
#
# Table name: formulations
#
#  id         :integer          not null, primary key
#  number     :integer
#  main_tag   :text
#  cream_base :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FormulationSerializer < ApplicationSerializer
  attribute :id
  attribute :number
  attribute :main_tag
  attribute :cream_base

  has_many :formulation_ingredients
  always_include :formulation_ingredients
end
