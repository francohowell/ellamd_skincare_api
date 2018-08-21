module V2
  class MedicalProfileSerializer
    attr_reader :medical_profile, :mode

    # Serialization modes: [:basic, :complete]
    def initialize(medical_profile, mode:)
      raise "Unknown mode: #{mode}" unless mode.in?(%i(basic complete))

      @medical_profile = medical_profile
      @mode            = mode
    end

    def as_json
      return nil if medical_profile.nil?

      {
        "id" => medical_profile.id,
        "customer-id" => medical_profile.customer_id,

        "date-of-birth" => medical_profile.date_of_birth&.strftime("%Y-%m-%d"),
        "sex" => medical_profile.sex,

        "skin-concerns" => medical_profile.skin_concerns,
        "skin-type" => medical_profile.skin_type,
        "preferred-fragrance" => medical_profile.preferred_fragrance,

        "sunscreen-frequency" => medical_profile.sunscreen_frequency,
        "sunscreen-brand" => medical_profile.sunscreen_brand,
        "user-skin-extra-details" => medical_profile.user_skin_extra_details,

        # Questions with optional details
        "is-smoker" => medical_profile.is_smoker,
        "is-pregnant" => medical_profile.is_pregnant,
        "is-breast-feeding" => medical_profile.is_breast_feeding,
        "is-on-birth-control" => medical_profile.is_on_birth_control,
        "has-been-on-accutane" => medical_profile.has_been_on_accutane,
        "has-hormonal-issues" => medical_profile.has_hormonal_issues,
        "current-nonprescription-topical-medications" => medical_profile.current_nonprescription_topical_medications,
        "past-nonprescription-topical-medications" => medical_profile.past_nonprescription_topical_medications,
        "past-prescription-topical-medications" => medical_profile.past_prescription_topical_medications,
        "past-prescription-oral-medications" => medical_profile.past_prescription_oral_medications,
        "using-peels" => medical_profile.using_peels,
        "using-retinol" => medical_profile.using_retinol,

        # Questions with required details
        "known-allergies" => medical_profile.known_allergies,
        "other-concerns" => medical_profile.other_concerns,
        "current-prescription-topical-medications" => medical_profile.current_prescription_topical_medications,
        "current-prescription-oral-medications" => medical_profile.current_prescription_oral_medications,
      }
    end
  end
end
