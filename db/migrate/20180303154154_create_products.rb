class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :store, null: false, size: 2
      t.integer :origin_id
      t.string :image_url
      t.string :product_url
      t.text :description
      t.text :diagnoses
      t.text :instructions

      t.jsonb :tags
      t.jsonb :packages

      t.float :average_rating
      t.integer :number_of_reviews

      t.jsonb :raw, null: false

      t.timestamps

      t.index ["name"], name: "index_products_on_name", unique: true, using: :btree
    end

    execute <<~SQL
      ALTER TABLE products
        ADD CONSTRAINT products_origin_id_fkey
        FOREIGN KEY (origin_id) REFERENCES products(id)
        ON DELETE CASCADE;
    SQL
  end
end
