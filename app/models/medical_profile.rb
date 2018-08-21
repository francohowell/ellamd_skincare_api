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

class MedicalProfile < ApplicationRecord
  audited

  belongs_to :customer, inverse_of: :medical_profile

  enum sex: %i(male female)

  enum skin_type: {
    very_light:      1,
    light:           2,
    light_to_medium: 3,
    medium:          4,
    medium_to_dark:  5,
    dark:            6
  }

  enum sunscreen_frequency: %i(daily few_times_week once_week rarely never)

  # TODO: change prescription.fragrance type to enum too before someone changes order of fragnances-
  enum preferred_fragrance: Prescription::FRAGRANCES

  question_with_optional_details :is_smoker,
                                 :is_pregnant,
                                 :is_breast_feeding,
                                 :is_on_birth_control,
                                 :has_been_on_accutane,
                                 :has_hormonal_issues,
                                 :current_nonprescription_topical_medications,
                                 :past_nonprescription_topical_medications,
                                 :past_prescription_topical_medications,
                                 :past_prescription_oral_medications,
                                 :using_peels,
                                 :using_retinol

  question_with_required_details :known_allergies,
                                 :other_concerns,
                                 :current_prescription_topical_medications,
                                 :current_prescription_oral_medications

  validates :sex,           presence: true, allow_nil: true
  validates :date_of_birth, presence: true, allow_nil: true
  validates :skin_concerns, presence: true, allow_nil: true

  validate :must_be_at_least_eighteen

  delegate :subscription, to: :customer

  # TODO: track changes only to "important" attributes
  def update_and_require_new_treatment_plan(params)
    assign_attributes(params)

    ApplicationRecord.transaction do
      subscription.unblock_with_profile_update(changes)
      save!
    end
  end

  ##
  # Ensure that the Customer is at least 18 years old.
  private def must_be_at_least_eighteen
    return if date_of_birth.nil? || date_of_birth < 18.years.ago

    errors[:date_of_birth] << "must be at least 18 years ago — EllaMD can only service patients " \
      "who are at least 18 years old"
  end
end
