class AddTokenToPrescriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :prescriptions, :token, :string

    Prescription.find_each do |prescription|
      prescription.send(:generate_token)
      prescription.save
    end
  end
end
