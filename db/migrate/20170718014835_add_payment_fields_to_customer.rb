class AddPaymentFieldsToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :prescription_credits, :integer, null: false, default: 0
    add_column :customers, :fulfillment_credits, :integer, null: false, default: 0
    add_column :customers, :order_cost, :integer, null: false, default: 149_00
    add_column :customers, :stripe_customer_id, :string
  end
end
