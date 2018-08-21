# == Schema Information
#
# Table name: visits
#
#  id                :integer          not null, primary key
#  customer_id       :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  payment_status    :integer          default("unpaid"), not null
#  stripe_invoice_id :string
#

class VisitSerializer < ApplicationSerializer
  attribute :id
  attribute :created_at
  attribute :updated_at
  attribute :payment_status

  has_many :photos
  always_include :photos

  has_one :diagnosis
  always_include :diagnosis

  has_one :prescription
  always_include :prescription

  has_one :regimen
  always_include :regimen
end
