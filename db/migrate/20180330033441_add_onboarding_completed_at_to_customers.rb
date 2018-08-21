class AddOnboardingCompletedAtToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :onboarding_completed_at, :datetime
  end
end
