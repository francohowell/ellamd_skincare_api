class CreateAdministrators < ActiveRecord::Migration[5.0]
  def change
    create_table :administrators do |t|
      t.references :identity, foreign_key: true

      t.timestamps
    end
  end
end
