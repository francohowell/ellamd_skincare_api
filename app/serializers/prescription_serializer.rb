# == Schema Information
#
# Table name: prescriptions
#
#  id                        :integer          not null, primary key
#  physician_id              :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  token                     :string
#  signa                     :text             default(""), not null
#  customer_instructions     :text             default(""), not null
#  pharmacist_instructions   :text             default(""), not null
#  tracking_number           :text
#  fragrance                 :string
#  cream_base                :string
#  volume_in_ml              :integer          default(15), not null
#  formulation_id            :integer
#  fulfilled_at              :datetime
#  visit_id                  :integer
#  not_downloaded_alerted_at :datetime
#  no_tracking_alerted_at    :datetime
#  is_copy                   :boolean          default(FALSE), not null
#

class PrescriptionSerializer < ApplicationSerializer
  include Rails.application.routes.url_helpers

  attribute :id
  attribute :token
  attributes :signa
  attribute :customer_instructions
  attribute :pharmacist_instructions
  attribute :tracking_number
  attribute :tracking_url
  attribute :cream_base
  attribute :fragrance
  attribute :volume_in_ml

  attribute :created_at
  attribute :fulfilled_at

  attribute :is_copy

  attribute(:pdf_url) { prescription_pdf_url(prescription_token: object.token) }

  attribute(:customer_first_name) { object.visit.customer.first_name }
  attribute(:customer_last_name) { object.visit.customer.last_name }

  belongs_to :physician

  has_one :formulation
  always_include :formulation

  has_many :prescription_ingredients
  always_include :prescription_ingredients

  attribute(:should_show_to_pharmacists) { object.should_show_to_pharmacists? }
end
