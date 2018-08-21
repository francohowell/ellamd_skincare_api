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

class RegimenProduct < ApplicationRecord
  belongs_to :regimen, inverse_of: :regimen_products
  belongs_to :product, inverse_of: :regimen_products

  enum period: %i(am pm)

  validates :product_id, presence: true
  validates :period,     presence: true
  validates :position,   numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
