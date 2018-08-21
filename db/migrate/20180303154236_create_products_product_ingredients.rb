class CreateProductsProductIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :products_product_ingredients do |t|
      t.integer :product_id, null: false
      t.integer :product_ingredient_id, null: false

      t.timestamps

      t.index ["product_id", "product_ingredient_id"],
              name: "index_products_product_ingredients_on_both_keys",
              unique: true,
              using: :btree
    end

    execute <<~SQL
      ALTER TABLE products_product_ingredients
        ADD CONSTRAINT products_product_ingredients_product_id_fkey
        FOREIGN KEY (product_id) REFERENCES products(id)
        ON DELETE CASCADE;

      ALTER TABLE products_product_ingredients
        ADD CONSTRAINT products_product_ingredients_product_ingredient_id_fkey
        FOREIGN KEY (product_ingredient_id) REFERENCES product_ingredients(id)
        ON DELETE CASCADE;
    SQL
  end
end
