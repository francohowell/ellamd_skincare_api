class AddLicensesToPhysicians < ActiveRecord::Migration[5.0]
  def change
    add_column :physicians, :state_license, :string
    add_column :physicians, :dea_license, :string
  end
end
