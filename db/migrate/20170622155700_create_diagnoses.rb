class CreateDiagnoses < ActiveRecord::Migration[5.0]
  def change
    create_table :diagnoses do |t|
      t.references :customer, foreign_key: true
      t.references :physician, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
