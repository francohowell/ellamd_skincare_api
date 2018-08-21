# == Schema Information
#
# Table name: regimen_products
#
#  id         :integer          not null, primary key
#  regimen_id :integer          not null
#  product_id :integer          not null
#  period     :integer          not null
#  position   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RegimenProductSerializer < ApplicationSerializer
  attribute :id

  attribute :period
  attribute :position

  belongs_to :product
  always_include :product
end
