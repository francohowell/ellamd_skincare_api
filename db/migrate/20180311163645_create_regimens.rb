class CreateRegimens < ActiveRecord::Migration[5.0]
  def up
    create_table :regimens do |t|
      t.integer :customer_id, null: false
      t.integer :physician_id
      t.integer :visit_id

      t.timestamps
    end

    execute <<~SQL
      ALTER TABLE regimens
        ADD CONSTRAINT regimens_customer_id_fkey
        FOREIGN KEY (customer_id) REFERENCES customers(id)
        ON DELETE CASCADE;

      ALTER TABLE regimens
        ADD CONSTRAINT regimens_physician_id_fkey
        FOREIGN KEY (physician_id) REFERENCES physicians(id)
        ON DELETE CASCADE;

      ALTER TABLE regimens
        ADD CONSTRAINT regimens_visit_id_fkey
        FOREIGN KEY (visit_id) REFERENCES visits(id)
        ON DELETE CASCADE;

      CREATE INDEX index_regimens_on_customer_id
        ON regimens (customer_id);
    SQL
  end

  def down
    drop_table :regimens
  end
end
