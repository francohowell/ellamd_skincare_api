# == Schema Information
#
# Table name: identities
#
#  id                     :integer          not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  email                  :string
#  first_name             :string
#  last_name              :string
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_type              :string
#  user_id                :integer
#

class IdentitySerializer < ApplicationSerializer
  attribute :id
  attribute :first_name
  attribute :last_name
  attribute :email

  attribute :user_type

  has_one :user
end
