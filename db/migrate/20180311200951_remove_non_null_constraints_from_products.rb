class RemoveNonNullConstraintsFromProducts < ActiveRecord::Migration[5.0]
  def change
    change_column_null :products, :raw, true
    change_column_null :products, :brand, true
  end
end
