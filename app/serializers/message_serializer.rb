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

class MessageSerializer < ApplicationSerializer
  attribute :id
  attribute :created_at

  attribute :content
  attribute :from_customer
  attribute :physician_id
  attribute :customer_id
end
