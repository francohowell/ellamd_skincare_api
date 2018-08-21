##
# AccessPolicy is an AccessGranted (gem) policy that defines our authorization scheme.
#
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
class AccessPolicy
  include AccessGranted::Policy

  ##
  # The `configure` method is called by AccessGranted to get the policy information.
  def configure
    ##
    # The Administrator role gives access to just about everything.
    role :administrator, ->(identity) { identity&.user.is_a?(Administrator) } do
      can [:create, :create_photo, :read, :update, :archive], Customer
      can [:create, :read], Pharmacist
      can [:read, :download, :add_tracking], Prescription
      can [:read, :sync], Product
      can [:read, :apply_code], Subscription
      can [:update_diagnosis, :update_prescription, :update_regimen, :update_photos, :delete], Visit
    end

    ##
    # The Physician role gives access to viewing Customers and creating Diagnoses and Prescriptions.
    role :physician, ->(identity) { identity&.user.is_a?(Physician) } do
      can [:read, :create_photo], Customer
      can [:update_diagnosis, :update_prescription, :update_regimen, :update_photos, :delete], Visit
      can [:read, :create], Message
    end

    ##
    # The Pharmacist role gives access to viewing Customers and downloading and updating
    # Prescriptions with tracking information.
    role :pharmacist, ->(identity) { identity&.user.is_a?(Pharmacist) } do
      can [:read, :download, :add_tracking], Prescription
    end

    ##
    # The Customer role allows the user to update their specific Customer object.
    role :customer, ->(identity) { identity&.user.is_a?(Customer) } do
      can [:update], Identity do |target_identity, identity|
        target_identity == identity
      end

      can [:read, :create_photo, :update], Customer do |customer, identity|
        customer == identity.user
      end

      can [:read, :update, :apply_code], Subscription do |subscription, identity|
        (identity.user_type == "Customer") && (subscription.customer_id == identity.user_id)
      end

      can [:read, :create], Message
    end

    role :authorized, ->(identity) { identity.present? } do
      can [:read], Physician
    end

    ##
    # The Guest role allows creation of a Customer and nothing else (the Customer role takes over
    # once one has been created).
    role :guest do
      can [:create], Customer
    end
  end
end
