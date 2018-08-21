class AddIsPendingToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :is_pending, :boolean, null: false, default: false
  end
end
