class SwitchSkinTypeToInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :ethnicity, :string
    remove_column :profiles, :sun_sensitivity, :float
    remove_column :profiles, :sun_exposure_in_minutes_per_day, :integer

    remove_column :profiles, :skin_type, :string
    add_column :profiles, :skin_type, :integer
  end
end
