class ChangeProductsStoreIdColumnType < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :store_id, :string

    execute <<~SQL
      ALTER TABLE product_ingredients
        ADD CONSTRAINT constraint_product_ingredients_on_name UNIQUE
        USING INDEX index_product_ingredients_on_name;

        ALTER TABLE products_product_ingredients
        ADD CONSTRAINT constraint_products_product_ingredients_on_both_keys UNIQUE
        USING INDEX index_products_product_ingredients_on_both_keys;
      SQL
  end
end
