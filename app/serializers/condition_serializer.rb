# == Schema Information
#
# Table name: conditions
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#

class ConditionSerializer < ApplicationSerializer
  attribute :id
  attribute :name
  attribute :description
end
