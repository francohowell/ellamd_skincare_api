class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.references :customer, foreign_key: true
      t.attachment :image
      t.float :rating

      t.timestamps
    end
  end
end
