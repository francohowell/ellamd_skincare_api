class RemoveDownloads < ActiveRecord::Migration[5.0]
  def up
    drop_table :downloads
  end
end
