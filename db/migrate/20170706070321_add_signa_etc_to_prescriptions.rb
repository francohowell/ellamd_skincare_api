class AddSignaEtcToPrescriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :prescriptions, :signa, :text, null: false, default: ""
    add_column :prescriptions, :customer_instructions, :text, null: false, default: ""
    add_column :prescriptions, :pharmacist_instructions, :text, null: false, default: ""

    remove_column :prescriptions, :note, :text
  end
end
