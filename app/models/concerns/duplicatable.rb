module Duplicatable
  extend ActiveSupport::Concern

  included do
    belongs_to :origin, inverse_of: :duplicates,
      class_name: self.to_s,
      foreign_key: "origin_id",
      optional: true

    has_many :duplicates, inverse_of: :origin,
      class_name: self.to_s,
      foreign_key: "origin_id"

    scope :without_duplicates, -> { where(origin_id: nil) }
  end

  def original?
    origin_id.blank?
  end

  def duplicate?
    origin_id.present?
  end

  def mark_as_original
    self.origin_id = nil
  end

  def mark_as_duplicate_of(origin)
    self.origin_id = origin.id
  end
end
