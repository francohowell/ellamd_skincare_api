class AddLastOnboardingStepToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :last_onboarding_step, :integer, null: false, default: 1
  end
end
