class ChangeProductsConstraints < ActiveRecord::Migration[5.0]
  def change
    execute <<~SQL
      DROP INDEX index_products_on_name;

      CREATE UNIQUE INDEX index_products_on_store_and_store_id
      ON products (store, store_id);

      ALTER TABLE products
        ADD CONSTRAINT constraint_products_on_store_and_store_id
        UNIQUE
        USING INDEX index_products_on_store_and_store_id;

      ALTER TABLE products
        ADD CONSTRAINT constraint_products_on_store_and_brand_and_name
        UNIQUE (store, brand, name);
    SQL
  end
end
