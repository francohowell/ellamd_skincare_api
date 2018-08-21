class CreateDiagnosisConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :diagnosis_conditions do |t|
      t.references :diagnosis, foreign_key: true
      t.references :condition, foreign_key: true

      t.timestamps
    end
  end
end
