class CreateAnnotations < ActiveRecord::Migration[5.0]
  def change
    create_table :annotations do |t|
      t.references :photo, foreign_key: true
      t.references :physician, foreign_key: true
      t.float :position_x, null: false
      t.float :position_y, null: false
      t.text :note

      t.timestamps
    end
  end
end
