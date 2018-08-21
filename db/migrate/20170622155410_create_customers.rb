class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.references :identity, foreign_key: true
      t.references :physician, foreign_key: true
      t.boolean :ready_for_physician

      t.timestamps
    end
  end
end
