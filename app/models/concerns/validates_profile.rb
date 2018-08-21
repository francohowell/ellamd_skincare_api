##
# Concern to validate various profile fields on Customer.
module ValidatesProfile
  extend ActiveSupport::Concern

  included do
    validates :phone, uniqueness: true, allow_blank: true, allow_nil: true

    validates :address_line_1, presence: true, allow_nil: true
    validates :city,           presence: true, allow_nil: true
    validates :state,          presence: true, allow_nil: true
    validates :zip_code,       presence: true, allow_nil: true

    validate :must_be_in_california
  end

  ##
  # Ensure that the Customer is in California.
  #
  # TODO: We should probably have richer handling of the `state` field. Checking for "California" or
  #   "CA" is a little bit hackish.
  def must_be_in_california
    return if state.nil? || state.casecmp("california").zero? || state.casecmp("ca").zero?

    errors.add(:state, "must be California — EllaMD only services California right now, but "\
      "will be coming to your state soon!")
  end

  ##
  # Is the Customer's profile blank?
  #
  # We use `date_of_birth` as a proxy to check the other profile fields as well. There was a short
  # time when the date of birth was the only required profile field, but this method is slightly out
  # of date.
  def profile_empty?
    zip_code.blank?
  end
end
