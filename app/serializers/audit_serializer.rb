# == Schema Information
#
# Table name: audits
#
#  id              :integer          not null, primary key
#  auditable_id    :integer
#  auditable_type  :string
#  associated_id   :integer
#  associated_type :string
#  user_id         :integer
#  user_type       :string
#  username        :string
#  action          :string
#  audited_changes :jsonb
#  version         :integer          default(0)
#  comment         :string
#  remote_address  :string
#  request_uuid    :string
#  created_at      :datetime
#

class AuditSerializer < ApplicationSerializer
  attribute :id

  attribute :user_id
  attribute :user_type

  attribute :action
  attribute :audited_changes
  attribute :version

  attribute :created_at
end
