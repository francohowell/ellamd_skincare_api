class AddNeedsProfileUpdateToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :needs_profile_update, :boolean, null: false, default: false
  end
end
