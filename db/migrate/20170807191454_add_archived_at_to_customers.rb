class AddArchivedAtToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :archived_at, :datetime
  end
end
