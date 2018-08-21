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

require "rails_helper"

describe MedicalProfile do
  let(:ben_raspail) { customers(:ben_raspail) }
  let(:ben_raspail_medical_profile) { medical_profiles(:ben_raspail_medical_profile) }

  describe "validations" do
    it "is valid and saveable with valid attributes" do
      medical_profile = FactoryBot.build(:medical_profile, customer: ben_raspail)

      expect(medical_profile).to be_valid
      expect(medical_profile.save).to be_truthy
    end

    it "should have at least one skin concern" do
      ben_raspail_medical_profile.skin_concerns = nil
      expect(ben_raspail_medical_profile).to be_valid

      ben_raspail_medical_profile.skin_concerns = ["acne"]
      expect(ben_raspail_medical_profile).to be_valid

      ben_raspail_medical_profile.skin_concerns = []
      expect(ben_raspail_medical_profile).not_to be_valid
    end

    it "#must_be_at_least_eighteen" do
      ben_raspail_medical_profile.date_of_birth = nil
      expect(ben_raspail_medical_profile).to be_valid

      ben_raspail_medical_profile.date_of_birth = Date.parse("2003-01-01")
      expect(ben_raspail_medical_profile).not_to be_valid

      ben_raspail_medical_profile.date_of_birth = Date.parse("2000-01-01")
      expect(ben_raspail_medical_profile).to be_valid
    end
  end
end
