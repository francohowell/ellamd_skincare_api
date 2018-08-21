class CreateProductIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :product_ingredients do |t|
      t.string :name, null: false
      t.integer :origin_id
      t.boolean :is_key, null: false, default: false

      t.timestamps

      t.index ["name"], name: "index_product_ingredients_on_name", unique: true, using: :btree
    end

    execute <<~SQL
      ALTER TABLE product_ingredients
        ADD CONSTRAINT product_ingredients_origin_id_fkey
        FOREIGN KEY (origin_id) REFERENCES product_ingredients(id)
        ON DELETE CASCADE;
      SQL
  end
end
