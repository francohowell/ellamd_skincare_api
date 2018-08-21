class CreatePrescriptionIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :prescription_ingredients do |t|
      t.references :prescription, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.float :amount, null: false, default: 0

      t.timestamps
    end
  end
end
