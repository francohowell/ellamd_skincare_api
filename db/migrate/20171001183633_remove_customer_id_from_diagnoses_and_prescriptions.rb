class RemoveCustomerIdFromDiagnosesAndPrescriptions < ActiveRecord::Migration[5.0]
  def up
    remove_column :diagnoses, :customer_id
    remove_column :prescriptions, :customer_id
  end
end
