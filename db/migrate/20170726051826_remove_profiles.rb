class RemoveProfiles < ActiveRecord::Migration[5.0]
  def up
    drop_table :profiles
  end
end
