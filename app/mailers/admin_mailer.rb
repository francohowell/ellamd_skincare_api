class AdminMailer < ApplicationMailer
  # These template IDs come from our SendGrid account's "Transactional Templates" section.
  PRESCRIPTION_NOT_DOWNLOADED_ADMIN_ALERT_TEMPLATE_ID = "8e29128b-2d48-49ef-9330-945dac8e4454".freeze
  PRESCRIPTION_WITHOUT_TRACKING_NUMBER_TEMPLATE_ID = "313be051-8ad8-42b6-a2e5-12c6ae0a8191".freeze

  # We open up the self class so that all of the below are class methods. This is a hackish way to
  # clean up the syntax a bit.
  #
  # TODO: A lot of the `send_...` methods are repetetive. There's an opportunity to DRY up much of
  #   the code below.
  class << self
    def send_prescription_not_downloaded_admin_alert(prescription, admin_user)
      send_template(
        template_id: PRESCRIPTION_NOT_DOWNLOADED_ADMIN_ALERT_TEMPLATE_ID,
        to_user: admin_user,
        substitutions: common_prescription_substitutions(prescription),
      )
    end

    def send_prescription_without_tracking_admin_alert(prescription, admin_user)
      send_template(
        template_id: PRESCRIPTION_WITHOUT_TRACKING_NUMBER_TEMPLATE_ID,
        to_user: admin_user,
        substitutions: common_prescription_substitutions(prescription),
      )
    end

    ##
    # Common substitution tags for a Prescription.
    private def common_prescription_substitutions(prescription)
      {
        "%prescription_id%" => prescription.id.to_s,
      }
    end
  end
end
