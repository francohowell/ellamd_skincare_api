class CreateFormulationIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :formulation_ingredients do |t|
      t.references :formulation, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
