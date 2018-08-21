class AddFragranceAndCreamBaseToPrescription < ActiveRecord::Migration[5.0]
  def change
    add_column :prescriptions, :fragrance, :string
    add_column :prescriptions, :cream_base, :string
  end
end
