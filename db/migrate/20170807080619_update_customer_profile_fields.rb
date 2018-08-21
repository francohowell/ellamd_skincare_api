class UpdateCustomerProfileFields < ActiveRecord::Migration[5.0]
  def change
    change_column :customers, :is_smoker, :text
    change_column :customers, :has_been_on_accutane, :text
    change_column :customers, :has_hormonal_issues, :text
    change_column :customers, :is_pregnant, :text
    change_column :customers, :is_breast_feeding, :text
    change_column :customers, :is_on_birth_control, :text

    rename_column :customers, :topical_medications, :current_prescription_topical_medications
    rename_column :customers, :prescription_medications, :current_prescription_oral_medications

    add_column :customers, :current_nonprescription_topical_medications, :text

    add_column :customers, :past_nonprescription_topical_medications, :text
    add_column :customers, :past_prescription_topical_medications, :text
    add_column :customers, :past_prescription_oral_medications, :text
  end
end
