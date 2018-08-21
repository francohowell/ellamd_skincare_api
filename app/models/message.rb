# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  customer_id   :integer          not null
#  physician_id  :integer          not null
#  from_customer :boolean          default(TRUE), not null
#  content       :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :customer,  inverse_of: :messages
  belongs_to :physician, inverse_of: :messages

  scope :with_physician, ->(physician_id) { where(physician_id: physician_id) }
end
