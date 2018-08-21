# == Schema Information
#
# Table name: regimens
#
#  id           :integer          not null, primary key
#  customer_id  :integer          not null
#  physician_id :integer
#  visit_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class RegimenSerializer < ApplicationSerializer
  attribute :id
  attribute :physician_id

  attribute :created_at
  attribute :updated_at

  has_many :regimen_products
  always_include :regimen_products
end
