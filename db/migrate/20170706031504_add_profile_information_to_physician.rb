class AddProfileInformationToPhysician < ActiveRecord::Migration[5.0]
  def change
    add_column :physicians, :address, :text
    add_column :physicians, :phone, :string
  end
end
