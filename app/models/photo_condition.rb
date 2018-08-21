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

class PhotoCondition < ApplicationRecord
  belongs_to :photo,     inverse_of: :photo_conditions
  belongs_to :condition, inverse_of: :photo_conditions
end
