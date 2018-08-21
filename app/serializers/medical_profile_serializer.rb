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

class MedicalProfileSerializer < ApplicationSerializer
  attribute :id
  attribute :customer_id

  date :date_of_birth
  attribute :sex

  attribute :skin_concerns
  attribute :skin_type
  attribute :preferred_fragrance

  attribute :sunscreen_frequency
  attribute :sunscreen_brand
  attribute :user_skin_extra_details

  # Questions with optional details
  attribute :is_smoker
  attribute :is_pregnant
  attribute :is_breast_feeding
  attribute :is_on_birth_control
  attribute :has_been_on_accutane
  attribute :has_hormonal_issues
  attribute :current_nonprescription_topical_medications
  attribute :past_nonprescription_topical_medications
  attribute :past_prescription_topical_medications
  attribute :past_prescription_oral_medications
  attribute :using_peels
  attribute :using_retinol

  # Questions with required details
  attribute :known_allergies
  attribute :other_concerns
  attribute :current_prescription_topical_medications
  attribute :current_prescription_oral_medications
end
