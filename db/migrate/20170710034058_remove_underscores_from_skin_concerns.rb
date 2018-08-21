class RemoveUnderscoresFromSkinConcerns < ActiveRecord::Migration[5.0]
  def change
    Profile.find_each do |profile|
      profile.skin_concerns = profile.skin_concerns.map { |skin_concern| skin_concern.tr("_", " ") }
      profile.save!
    end
  end
end
