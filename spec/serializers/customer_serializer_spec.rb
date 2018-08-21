# == Schema Information
#
# Table name: customers
#
#  id                      :integer          not null, primary key
#  physician_id            :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  address_line_1          :string
#  address_line_2          :string
#  zip_code                :string
#  state                   :string
#  city                    :string
#  phone                   :string
#  archived_at             :datetime
#  last_onboarding_step    :integer          default(1), not null
#  onboarding_completed_at :datetime
#

require "rails_helper"

describe CustomerSerializer do
  let(:ben_raspail) { customers(:ben_raspail) }

  it "successfully renders Customer as json" do
    result = serialize(ben_raspail)

    expect(result["id"]).to be_present
    expect(result["subscription"]).to be_present
    expect(result["medical-profile"]).to be_present
  end
end
