# == Schema Information
#
# Table name: physicians
#
#  id                           :integer          not null, primary key
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  signature_image_file_name    :string
#  signature_image_content_type :string
#  signature_image_file_size    :integer
#  signature_image_updated_at   :datetime
#  state_license                :string
#  dea_license                  :string
#  address                      :text
#  phone                        :string
#

##
# A Physician is a user that can view Customers and write Diagnoses and Prescriptions.
class Physician < ApplicationRecord
  include HasIdentity

  has_many :customers,     inverse_of: :physician
  has_many :prescriptions, inverse_of: :physician, dependent: :destroy
  has_many :diagnoses,     inverse_of: :physician, dependent: :destroy
  has_many :regimens,      inverse_of: :physician, dependent: :destroy
  has_many :annotations,   inverse_of: :physician, dependent: :destroy
  has_many :messages,      inverse_of: :physician, dependent: :destroy

  has_attached_file :signature_image,
    styles: {small: "100x100>", medium: "300x300>", large: "1200x1200>"},
    path: "/signatures/:hash_:style.:extension"

  validates_attachment :signature_image, content_type: {
    content_type: ["image/jpeg", "image/gif", "image/png"],
  }

  def address
    read_attribute(:address) || ""
  end
end
