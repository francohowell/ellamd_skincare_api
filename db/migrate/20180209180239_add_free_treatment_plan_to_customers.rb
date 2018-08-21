class AddFreeTreatmentPlanToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :free_treatment_plan, :boolean, default: false, null: false
  end
end
