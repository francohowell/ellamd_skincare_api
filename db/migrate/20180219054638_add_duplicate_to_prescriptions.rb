class AddDuplicateToPrescriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :prescriptions, :is_copy, :boolean, null: false, default: false
  end
end
