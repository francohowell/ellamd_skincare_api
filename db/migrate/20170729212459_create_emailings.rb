class CreateEmailings < ActiveRecord::Migration[5.0]
  def change
    create_table :emailings do |t|
      t.references :identity, foreign_key: true
      t.string :template_id, null: false

      t.timestamps
    end
  end
end
