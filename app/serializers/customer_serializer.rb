# == Schema Information
#
# Table name: customers
#
#  id                      :integer          not null, primary key
#  physician_id            :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  address_line_1          :string
#  address_line_2          :string
#  zip_code                :string
#  state                   :string
#  city                    :string
#  phone                   :string
#  archived_at             :datetime
#  last_onboarding_step    :integer          default(1), not null
#  onboarding_completed_at :datetime
#

class CustomerSerializer < ApplicationSerializer
  attribute :id
  attribute :physician_id

  attribute :first_name
  attribute :last_name
  attribute :email

  attribute :address_line_1
  attribute :address_line_2
  attribute :zip_code
  attribute :state
  attribute :city
  attribute(:phone) { object.phone&.phony_formatted }

  attribute :created_at
  attribute :onboarding_completed_at
  attribute :updated_at

  attribute :last_onboarding_step

  belongs_to :physician
  always_include :physician

  has_one :subscription
  always_include :subscription

  has_one :medical_profile
  always_include :medical_profile

  has_one :actual_regimen
  always_include :actual_regimen

  has_many :visits
  always_include :visits

  has_many :photos
  always_include :photos
end
