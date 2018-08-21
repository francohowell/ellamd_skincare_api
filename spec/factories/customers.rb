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

FactoryBot.define do
  factory :customer do
    # set physician yourself
  end
end
