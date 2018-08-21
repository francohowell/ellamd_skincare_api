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

FactoryBot.define do
  factory :regimen do
    # Set customer yourself
  end
end
