# == Schema Information
#
# Table name: administrators
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

##
# An Administrator is a user that can do just about anything in the app.
class Administrator < ApplicationRecord
  include HasIdentity
end
