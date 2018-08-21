class MoveFreeTreatmentPlanFromCustomersToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :free_treatment_plan

    add_column :subscriptions,
               :initial_treatment_plan_is_free,
               :boolean,
               null: false,
               default: false
  end
end
