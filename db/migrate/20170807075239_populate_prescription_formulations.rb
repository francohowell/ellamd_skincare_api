class PopulatePrescriptionFormulations < ActiveRecord::Migration[5.0]
  def change
    Prescription.find_each do |prescription|
      prescription.update!(formulation: prescription.computed_formulation)
    end
  end
end
