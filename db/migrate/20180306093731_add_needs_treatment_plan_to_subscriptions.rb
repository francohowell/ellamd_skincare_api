class AddNeedsTreatmentPlanToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :needs_treatment_plan, :boolean, null: false, default: true
    add_column :subscriptions, :has_payment_source, :boolean, null: false, default: false
  end
end
