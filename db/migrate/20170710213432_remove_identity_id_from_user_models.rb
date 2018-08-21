class RemoveIdentityIdFromUserModels < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :identity_id, :integer
    remove_column :physicians, :identity_id, :integer
    remove_column :pharmacists, :identity_id, :integer
    remove_column :administrators, :identity_id, :integer
  end
end
