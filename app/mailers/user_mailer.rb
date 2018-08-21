##
# A plain-old Ruby class to handle email for our users.
#
# Note that this doesn't inherit from ActionMailer::Base as we're using SendGrid's Web API, not
# their SMTP API, to send mail and thus don't need the ActionMailer functionality.
#
# rubocop:disable Metrics/ClassLength
class UserMailer < ApplicationMailer
  # These template IDs come from our SendGrid account's "Transactional Templates" section.
  TEMPLATES = {
    forgot_password: "4b193bbd-ab80-4ff1-95d7-6fe7e6b5b12b",
    forgot_password_3rd_party_provider: "e08b4691-5df4-4a4e-8436-9312948d4eb9",

    recurring_visit_created: "8a3bae2d-113d-4113-a04e-2d545fd811fb",
    recurring_visit_created_and_blocked: "93a42964-6738-4b4e-85e0-f4e972790dd6",

    invoice_payment_succeeded: "207b56dd-b5c5-4e33-bca9-9e075a87599e",
    invoice_payment_failed: "1d2cb960-f95a-466a-a962-dbb9ca72f0d4",

    prescription_shipped: "98fc67d2-d94c-4a07-b213-d176291bf0e3",
    prescription_delivered: "90f56b0f-520d-4f0b-9b59-d5d21757b823",
  }

  INCOMPLETE_SIGNUP_REMINDER_TEMPLATE_ID = "9d3b2be0-734b-4747-926b-6e8ba17e13be".freeze
  PHYSICIAN_DAILY_TEMPLATE_ID = "f0c1ef47-ff5f-40c2-9ee9-2f099369c991".freeze
  PRESCRIPTION_READY_PAID_TEMPLATE_ID = "dc96a647-d1d5-47b4-a570-a0bc21acd4ad".freeze
  PRESCRIPTION_READY_UNPAID_TEMPLATE_ID = "6ba95adb-5aa7-41a3-b3a2-b8b5c9fcae47".freeze
  SIGNUP_COMPLETE_PAID_TEMPLATE_ID = "56d21f61-0597-4241-9cca-efcee5d1ace1".freeze
  SIGNUP_COMPLETE_UNPAID_TEMPLATE_ID = "0e0a532a-27e2-486d-b2df-4abd6f9973a1".freeze

  # We open up the self class so that all of the below are class methods. This is a hackish way to
  # clean up the syntax a bit.
  #
  # TODO: A lot of the `send_...` methods are repetetive. There's an opportunity to DRY up much of
  #   the code below.
  class << self
    def send_email(template:, user:)
      send_template(
        template_id: TEMPLATES.fetch(template),
        to_user: user,
        substitutions: common_user_substitutions(user)
      )
    end

    def send_customer_signup_complete_paid_email(customer)
      send_template(
        template_id: SIGNUP_COMPLETE_PAID_TEMPLATE_ID,
        to_user: customer,
        substitutions: common_user_substitutions(customer),
      )
    end

    def send_customer_signup_complete_unpaid_email(customer)
      send_template(
        template_id: SIGNUP_COMPLETE_UNPAID_TEMPLATE_ID,
        to_user: customer,
        substitutions: common_user_substitutions(customer),
      )
    end

    def send_customer_incomplete_signup_reminder(customer)
      # Intentionally blank per Jeremy's specs.

      # TODO: Re-enable this eventually.

      # send_template(
      #   template_id: INCOMPLETE_SIGNUP_REMINDER_TEMPLATE_ID,
      #   to_user: customer,
      #   substitutions: common_user_substitutions(customer),
      # )
    end

    def send_prescription_ready_paid_email(prescription)
      send_template(
        template_id: PRESCRIPTION_READY_PAID_TEMPLATE_ID,
        to_user: prescription.customer,
        substitutions: common_user_substitutions(prescription.customer),
      )
    end

    def send_prescription_ready_unpaid_email(prescription)
      send_template(
        template_id: PRESCRIPTION_READY_UNPAID_TEMPLATE_ID,
        to_user: prescription.customer,
        substitutions: common_user_substitutions(prescription.customer),
      )
    end

    def send_prescription_shipped_email(prescription)
      send_template(
        template_id: TEMPLATES.fetch(:prescription_shipped),
        to_user: prescription.customer,
        substitutions: common_user_substitutions(prescription.customer)
          .merge(
            "%tracking_number%" => prescription.tracking_number,
            "%tracking_url%" => prescription.tracking_url
          ),
      )
    end

    def send_prescription_delivered_email(prescription)
      send_template(
        template_id: TEMPLATES.fetch(:prescription_delivered),
        to_user: prescription.customer,
        substitutions: common_user_substitutions(prescription.customer),
      )
    end

    def send_physician_daily_email(physician)
      send_template(
        template_id: PHYSICIAN_DAILY_TEMPLATE_ID,
        to_user: physician,
        substitutions: {
          "%list_of_customers_requiring_treatment_plan%" =>
            Visit.includes(:customer)
                .waiting_for_rx
                .map(&:customer)
                .map(&:physician_daily_email_link_html)
                .join("<br />")
        },
      )
    end

    def send_user_forgot_password_email(user, redirect_url, token)
      redirect_url = redirect_url.gsub(":token", token)
      send_template(
        template_id: TEMPLATES.fetch(:forgot_password),
        to_user: user,
        substitutions: common_user_substitutions(user)
          .merge("%password_reset_link%" => "<a href='#{redirect_url}'>#{redirect_url}</a>"),
      )
    end

    ##
    # Common substitution tags for a User.
    private def common_user_substitutions(user)
      substitutions = ({
        "%first_name%" => user.first_name,
        "%last_name%"  => user.last_name,
      })

      if user.is_a?(Customer)
        substitutions.merge!({
          "%provider%" => user.identity.provider.capitalize
        })
      end

      substitutions
    end
  end
end
