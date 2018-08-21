class RenameBooleanFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :ready_for_physician, :boolean

    rename_column :customers, :smoker, :is_smoker
    rename_column :customers, :been_on_accutane, :has_been_on_accutane
    rename_column :customers, :hormonal_issues, :has_hormonal_issues
    rename_column :customers, :pregnant, :is_pregnant
    rename_column :customers, :breast_feeding, :is_breast_feeding
    rename_column :customers, :birth_control, :is_on_birth_control

    rename_column :ingredients, :premium, :is_premium
    rename_column :ingredients, :prescription, :is_prescription_required
  end
end
