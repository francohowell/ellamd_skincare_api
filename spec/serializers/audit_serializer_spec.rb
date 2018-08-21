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

require "rails_helper"

describe AuditSerializer do
  let(:ben_raspail_medical_profile) { medical_profiles(:ben_raspail_medical_profile) }

  it "successfully renders Audit as json" do
    ben_raspail_medical_profile.update_attributes!(is_pregnant: true)
    audit  = ben_raspail_medical_profile.audits.last
    result = serialize(audit)

    expect(result["id"]).to be_present
  end
end
