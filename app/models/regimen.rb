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

class Regimen < ApplicationRecord
  belongs_to :customer,  inverse_of: :regimens
  belongs_to :physician, inverse_of: :regimens
  belongs_to :visit,     inverse_of: :regimen

  has_many :regimen_products, inverse_of: :regimen, autosave: true, dependent: :destroy
  has_many :products, through: :regimen_products

  def make_copy_of(another_regimen)
    regimen_products.each do |regimen_product|
      regimen_product.mark_for_destruction
    end

    another_regimen.regimen_products.each do |another_regimen_product|
      regimen_products.build(
        period: another_regimen_product.period,
        position: another_regimen_product.position,
        product_id: another_regimen_product.product_id
      )
    end
  end
end
