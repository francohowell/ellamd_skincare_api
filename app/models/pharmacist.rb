# == Schema Information
#
# Table name: pharmacists
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

##
# An Administrator is a user that can download, fulfill, and add tracking to Prescriptions.
class Pharmacist < ApplicationRecord
  include HasIdentity
end
