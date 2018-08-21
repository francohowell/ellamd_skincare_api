# == Schema Information
#
# Table name: emailings
#
#  id          :integer          not null, primary key
#  identity_id :integer
#  template_id :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

##
# An Emailing is a delivery of a specific email template to a specific user.
#
# We track these Emailings so that we don't send duplicate emails to users, etc.
class Emailing < ApplicationRecord
  belongs_to :identity, inverse_of: :emailings
end
