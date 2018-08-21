class RemoveProductsStoreBrandNameUniqConstraintForNow < ActiveRecord::Migration[5.0]
  def change
    execute <<~SQL
      ALTER TABLE products
        DROP CONSTRAINT constraint_products_on_store_and_brand_and_name;
      DROP INDEX IF EXISTS constraint_products_on_store_and_brand_and_name;

      ALTER INDEX constraint_products_on_store_and_store_id
        RENAME TO index_products_on_store_and_store_id_unique;
    SQL
  end
end
