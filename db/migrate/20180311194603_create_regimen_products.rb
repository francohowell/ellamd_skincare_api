class CreateRegimenProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :regimen_products do |t|
      t.integer :regimen_id, null: false
      t.integer :product_id, null: false
      t.integer :period,     null: false, limit: 2
      t.integer :position,   null: false, limit: 2

      t.timestamps
    end

    execute <<~SQL
      ALTER TABLE regimen_products
        ADD CONSTRAINT regimen_products_regimen_id_fkey
        FOREIGN KEY (regimen_id) REFERENCES regimens(id)
        ON DELETE CASCADE;

      ALTER TABLE regimen_products
        ADD CONSTRAINT regimen_products_product_id_fkey
        FOREIGN KEY (product_id) REFERENCES products(id)
        ON DELETE CASCADE;

      CREATE INDEX index_regimen_products_on_regimen_id
        ON regimen_products (regimen_id);
    SQL
  end
end
