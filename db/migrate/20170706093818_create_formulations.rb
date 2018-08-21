class CreateFormulations < ActiveRecord::Migration[5.0]
  def change
    create_table :formulations do |t|
      t.integer :number
      t.text :main_tag
      t.string :cream_base

      t.timestamps
    end
  end
end
