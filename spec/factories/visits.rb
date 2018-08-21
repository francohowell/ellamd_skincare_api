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

FactoryBot.define do
  factory :visit do
    # Set customer yourself
    payment_status Visit.payment_statuses[:unpaid]
  end
end
