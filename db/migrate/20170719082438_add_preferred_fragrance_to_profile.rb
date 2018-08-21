class AddPreferredFragranceToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :preferred_fragrance, :string

    Profile.find_each { |profile| profile.update!(preferred_fragrance: "no_scent") }
  end
end
