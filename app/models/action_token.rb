# == Schema Information
#
# Table name: action_tokens
#
#  id             :integer          not null, primary key
#  token          :string
#  owner_type     :string
#  owner_id       :integer
#  tokenable_type :string
#  tokenable_id   :integer
#  used_at        :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ActionToken < ApplicationRecord
  has_secure_token

  VALIDITY_TIME = 1.day.freeze

  belongs_to :owner,     polymorphic: true
  belongs_to :tokenable, polymorphic: true

  validates :owner,     presence: true
  validates :tokenable, presence: true

  def used?
    used_at.present?
  end

  def expired?
    DateTime.now > created_at + VALIDITY_TIME
  end

  def good?(object_id)
    !used? && !expired? && tokenable_id == object_id
  end

  def mark_as_used
    update! used_at: DateTime.now
  end
end
