##
# Concern to include an Identity association and related delegations.
#
# This concern is used on Administrator, Customer, Physician, and Pharmacist to provide them with
# Devise-based authentication functionality via the Identity model.
module HasIdentity
  extend ActiveSupport::Concern

  included do
    has_one :identity, as: :user, dependent: :destroy, validate: true

    delegate :first_name, to: :identity
    delegate :last_name,  to: :identity
    delegate :email,      to: :identity

    accepts_nested_attributes_for :identity
  end
end
