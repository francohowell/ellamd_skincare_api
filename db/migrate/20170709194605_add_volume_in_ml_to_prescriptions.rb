class AddVolumeInMlToPrescriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :prescriptions, :volume_in_ml, :integer, null: false, default: 15
  end
end
