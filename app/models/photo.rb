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

##
# A Photo is an image attached to a Customer.
#
# Photos are one of the main ways that a Customer communicates with a Physician. The Photos allow
# the Physician to remotely diagnose the Customer and prescribe an appropriate skincare routine.
# There is little structure around specific perspectives, numbers of photos, etc., but that might
# be changed in the future (e.g. by enforcing that a Customer provides three Photos per
# Prescription, or enforcing profile vs. head-on shots).
class Photo < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :customer, inverse_of: :photos
  belongs_to :visit,    inverse_of: :photos

  has_many :photo_conditions, inverse_of: :photo, dependent: :destroy
  has_many :annotations,      inverse_of: :photo, dependent: :destroy

  has_attached_file :image,
    styles: {thumbnail: "100x100#", small: "400x400>", medium: "800x800>", large: "2400x2400>"},
    path: "/photos/:hash_:style.:extension",
    validate_media_type: false

  validates :customer, presence: true
  validates :image, attachment_presence: true
  validates_attachment :image, content_type: {
    content_type: ["image/jpeg", "image/gif", "image/png"],
  }
end
