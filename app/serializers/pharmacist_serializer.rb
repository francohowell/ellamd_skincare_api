# == Schema Information
#
# Table name: pharmacists
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PharmacistSerializer < ApplicationSerializer
  attribute :id
  attribute :first_name
  attribute :last_name
  attribute :email
end
