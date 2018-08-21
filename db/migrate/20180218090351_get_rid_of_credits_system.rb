class GetRidOfCreditsSystem < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :prescription_credits
    remove_column :customers, :fulfillment_credits
    # remove_column :customers, :order_cost
  end
end
