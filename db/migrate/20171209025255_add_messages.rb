class AddMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :customer, foreign_key: true, null: false
      t.references :physician, foreign_key: true, null: false
      t.boolean :from_customer, null: false, default: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
