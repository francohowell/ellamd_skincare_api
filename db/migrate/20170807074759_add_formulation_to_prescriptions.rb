class AddFormulationToPrescriptions < ActiveRecord::Migration[5.0]
  def change
    add_reference :prescriptions, :formulation, foreign_key: true
  end
end
