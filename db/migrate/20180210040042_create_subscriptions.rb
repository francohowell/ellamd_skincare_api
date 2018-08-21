class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      # Status:
      #   - inexistent
      #   - active
      #   - paused
      #   - cancelled
      t.integer  :status,                 size: 2, null: false, default: 0
      t.integer  :customer_id,                     null: false
      t.string   :stripe_subscription_id
      t.datetime :next_visit_at

      t.timestamps
    end

    execute <<~SQL
      ALTER TABLE subscriptions
        ADD CONSTRAINT subscriptions_customer_id_fkey
        FOREIGN KEY (customer_id) REFERENCES customers(id)
        ON DELETE CASCADE;
    SQL
  end
end
