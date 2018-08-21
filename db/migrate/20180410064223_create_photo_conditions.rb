class CreatePhotoConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :photo_conditions do |t|
      t.references :photo, foreign_key: true
      t.references :condition, foreign_key: true
      t.text :note
      t.text :canvas_data

      t.timestamps
    end
  end
end
