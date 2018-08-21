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

class PhysicianSerializer < ApplicationSerializer
  attribute :id
  attribute :first_name
  attribute :last_name
  attribute :email
  attribute(:signature_image_url) { object.signature_image.url }
end
