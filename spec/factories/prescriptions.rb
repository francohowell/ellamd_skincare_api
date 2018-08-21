# == Schema Information
#
# Table name: prescriptions
#
#  id                        :integer          not null, primary key
#  physician_id              :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  token                     :string
#  signa                     :text             default(""), not null
#  customer_instructions     :text             default(""), not null
#  pharmacist_instructions   :text             default(""), not null
#  tracking_number           :text
#  fragrance                 :string
#  cream_base                :string
#  volume_in_ml              :integer          default(15), not null
#  formulation_id            :integer
#  fulfilled_at              :datetime
#  visit_id                  :integer
#  not_downloaded_alerted_at :datetime
#  no_tracking_alerted_at    :datetime
#  is_copy                   :boolean          default(FALSE), not null
#

FactoryBot.define do
  factory :prescription do
    # Set visit_id yourself
    physician { Physician.first }
    prescription_ingredients { [PrescriptionIngredient.first] }

    token { |n| "ELLAMD-FB-#{n}" }
    fragrance "no_scent"
    cream_base "hrt"
  end
end
