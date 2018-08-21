class EnableFtsExtensions < ActiveRecord::Migration[5.0]
  def change
    def up
      execute "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
      execute "CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;"
    end

    def down
      execute "DROP EXTENSION IF EXISTS pg_trgm;"
      execute "DROP EXTENSION IF EXISTS fuzzystrmatch;"
    end
  end
end
