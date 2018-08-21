class PopulateFulfilledAtOnPrescriptions < ActiveRecord::Migration[5.0]
  class Prescription < ApplicationRecord
    has_many :downloads
  end

  class Download < ApplicationRecord; end

  def change
    Prescription.find_each do |prescription|
      next unless prescription.downloads.any?

      fulfilled_at = prescription.downloads.order(created_at: :asc).first.created_at
      prescription.update!(fulfilled_at: fulfilled_at)
    end
  end
end
