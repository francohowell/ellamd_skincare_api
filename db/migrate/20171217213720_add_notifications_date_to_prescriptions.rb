class AddNotificationsDateToPrescriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :prescriptions, :not_downloaded_alerted_at, :datetime
    add_column :prescriptions, :no_tracking_alerted_at, :datetime
  end
end
