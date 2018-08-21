class CreatePharmacists < ActiveRecord::Migration[5.0]
  def change
    create_table :pharmacists do |t|
      t.references :identity, foreign_key: true

      t.timestamps
    end
  end
end
