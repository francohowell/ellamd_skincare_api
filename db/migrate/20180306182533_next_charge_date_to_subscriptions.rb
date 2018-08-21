class NextChargeDateToSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :subscriptions, :next_charge_at, :datetime
  end
end
