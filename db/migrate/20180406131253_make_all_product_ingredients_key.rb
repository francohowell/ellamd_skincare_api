class MakeAllProductIngredientsKey < ActiveRecord::Migration[5.1]
  def change
    change_column_default :product_ingredients, :is_key, :true

    execute <<~SQL
      UPDATE product_ingredients SET is_key = true;
    SQL
  end
end
