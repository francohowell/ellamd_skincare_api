class AddStripeInvoiceIdToVisits < ActiveRecord::Migration[5.0]
  def change
    add_column :visits, :stripe_invoice_id, :string
  end
end
