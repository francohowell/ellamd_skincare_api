# == Schema Information
#
# Table name: medical_profiles
#
#  id                                          :integer          not null, primary key
#  customer_id                                 :integer          not null
#  sex                                         :integer
#  date_of_birth                               :datetime
#  is_smoker                                   :text
#  is_pregnant                                 :text
#  is_breast_feeding                           :text
#  is_on_birth_control                         :text
#  known_allergies                             :text
#  current_prescription_oral_medications       :text
#  current_prescription_topical_medications    :text
#  current_nonprescription_topical_medications :text
#  past_prescription_oral_medications          :text
#  past_prescription_topical_medications       :text
#  past_nonprescription_topical_medications    :text
#  using_peels                                 :text
#  using_retinol                               :text
#  has_been_on_accutane                        :text
#  has_hormonal_issues                         :text
#  other_concerns                              :text
#  preferred_fragrance                         :integer
#  skin_type                                   :integer
#  skin_concerns                               :jsonb
#  sunscreen_frequency                         :integer
#  sunscreen_brand                             :string
#  user_skin_extra_details                     :string
#  created_at                                  :datetime         not null
#  updated_at                                  :datetime         not null
#

FactoryBot.define do
  factory :medical_profile do
    # Set :customer_id yourself
  end
end
