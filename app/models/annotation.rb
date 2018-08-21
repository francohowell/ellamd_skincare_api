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

class Annotation < ApplicationRecord
  default_scope { order(id: :asc) }

  belongs_to :photo,     inverse_of: :annotations
  belongs_to :physician, inverse_of: :annotations

  validates :photo,      presence: true
  validates :physician,  presence: true
  validates :position_x, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 1}
  validates :position_y, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 1}
end
