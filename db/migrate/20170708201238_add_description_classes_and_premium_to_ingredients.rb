class AddDescriptionClassesAndPremiumToIngredients < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :description, :text
    add_column :ingredients, :classes, :string, array: true, null: false, default: []
    add_column :ingredients, :premium, :boolean, null: false, default: false
    add_column :ingredients, :prescription, :boolean, null: false, default: false
  end
end
