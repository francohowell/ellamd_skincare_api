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

##
# An Identity is the main Devise model of the app.
#
# You can think of Identities as the typical `User` class in most applications. Due to some
# peculiarities in the original specifications, this class isn't named User, but probably should be.
#
# Instead of using a User superclass and STI or some other form of inheritance to represent the
# difference between Customers, Physicians, Pharmacists, and Administrators (the four types of
# users of this app), we use this Identity model to store the common authentication functionality
# and give it a polymorphic association to its user (one of the four classes mentioned above).
class Identity < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  include TracksEmailings

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
    :validatable

  belongs_to :user, polymorphic: true, validate: true

  has_many :emailings, inverse_of: :identity, dependent: :destroy

  validates :user, presence: true
  validates :user_id, uniqueness: {scope: :user_type}
  validates :email,      uniqueness: true
  validates :first_name, presence: true
  validates :last_name,  presence: true

  ##
  # A helper method to concatenate the Identity's first and last names.
  def full_name
    "#{first_name} #{last_name}".strip
  end

  ##
  # Overridden method called by Devise to send a confirmation email.
  #
  # We replace this method with a no-op because we don't want to send confirmation emails when
  # the Identity is created.
  def send_confirmation_instructions; end

  ##
  # Overridden method called by Devise to check to see if confirmation is required.
  #
  # Like `send_confirmation_instructions`, this is basically a no-op because we don't want to
  # require confirmation but DeviseTokenAuth doesn't respect removing `confirmable` from the Devise
  # configuration.
  def confirmation_required?
    skip_confirmation! unless destroyed?
  end

  ##
  # Overridden method called by Devise to send a password-reset email.
  def send_reset_password_instructions(**options)
    token = set_reset_password_token
    UserMailer.send_user_forgot_password_email(user, options[:redirect_url], token)
  end
end
