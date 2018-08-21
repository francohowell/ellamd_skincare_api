class AddPaymentStatusToVisits < ActiveRecord::Migration[5.0]
  def change
    add_column :visits, :payment_status, :smallint, null: false, default: 0
  end
end
