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

FactoryBot.define do
  factory :regimen_product do
    # Set regimen yourself
    # Set product yourself
    period :am
    position { |n| n }
  end
end
