class FixTextFieldDefaultValues < ActiveRecord::Migration[5.0]
  TEXT_FIELDS = [
    "is_smoker",
    "has_been_on_accutane",
    "has_hormonal_issues",
    "is_pregnant",
    "is_breast_feeding",
    "is_on_birth_control",
    "other_concerns",
    "current_prescription_topical_medications",
    "current_prescription_oral_medications",
    "known_allergies",
    "current_nonprescription_topical_medications",
    "past_nonprescription_topical_medications",
    "past_prescription_topical_medications",
    "past_prescription_oral_medications",
  ].freeze

  def change
    Customer.find_each do |customer|
      TEXT_FIELDS.each do |text_field|
        if customer[text_field] == "" || customer[text_field] == "true"
          customer.update!(text_field.to_sym => "---")
        elsif customer[text_field] == "false"
          customer.update!(text_field.to_sym => nil)
        end
      end
    end
  end
end
