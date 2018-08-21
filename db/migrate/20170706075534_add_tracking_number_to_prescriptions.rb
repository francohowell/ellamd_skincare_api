class AddTrackingNumberToPrescriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :prescriptions, :tracking_number, :text
  end
end
