# == Schema Information
#
# Table name: annotations
#
#  id           :integer          not null, primary key
#  photo_id     :integer
#  physician_id :integer
#  position_x   :float            not null
#  position_y   :float            not null
#  note         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AnnotationSerializer < ApplicationSerializer
  attribute :id
  attribute :created_at

  attribute :position_x
  attribute :position_y
  attribute :note
end
