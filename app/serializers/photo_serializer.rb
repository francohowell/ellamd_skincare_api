# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  customer_id        :integer
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  rating             :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  visit_id           :integer
#

class PhotoSerializer < ApplicationSerializer
  attribute :id
  attribute :created_at

  attribute(:thumbnail_url) { object.image.url(:thumbnail) }
  attribute(:small_url) { object.image.url(:small) }
  attribute(:medium_url) { object.image.url(:medium) }
  attribute(:large_url) { object.image.url(:large) }

  has_many :annotations
  always_include :annotations

  has_many :photo_conditions
  always_include :photo_conditions

  attribute :visit_id
end
