# == Schema Information
#
# Table name: photo_conditions
#
#  id           :bigint(8)        not null, primary key
#  photo_id     :bigint(8)
#  condition_id :bigint(8)
#  note         :text
#  canvas_data  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PhotoConditionSerializer < ApplicationSerializer
  attribute :id
  attribute :created_at

  attribute :note
  attribute :canvas_data

  belongs_to :condition
  always_include :condition
end
