class CreateDownloads < ActiveRecord::Migration[5.0]
  def change
    create_table :downloads do |t|
      t.references :prescription, foreign_key: true

      t.timestamps
    end
  end
end
