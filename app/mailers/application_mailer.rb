class ApplicationMailer
  DEFAULT_FROM_EMAIL = "hello@ellamd.com".freeze
  DEFAULT_FROM_NAME = "EllaMD".freeze

  BCC_ALL_MAIL_TO_EMAIL = "customers+record@ellamd.com".freeze

  SENDGRID_API_HANDLE = SendGrid::API.new(
    api_key: Figaro.env.sendgrid_api_key!,
    host: "https://api.sendgrid.com",
  )

  class << self
    ##
    # Asynchronously send a template to a given recipient with the given substitutions made.
    #
    # Either `to_user` or both `to_email` and `to_name` should be provided. If the former is
    # provided, the name and email address are pulled in from the user. This method is primarily
    # boilerplate to interact with the SendGrid Web API.
    #
    # rubocop:disable Metrics/AbcSize
    handle_asynchronously def send_template(
      template_id:,
      to_user: nil,
      to_email: nil,
      to_name: "",
      substitutions: {}
    )

      raise Exceptions::ApplicationError, "need a receipient" if to_user.nil? && to_email.nil?

      if to_user
        to_email = to_user.email
        to_name = "#{to_user.first_name} #{to_user.last_name}"

        # We create an Emailing to track the delivery of this message.
        to_user.identity.emailings.create!(template_id: template_id)
      end

      mail = SendGrid::Mail.new
      mail.from = SendGrid::Email.new(email: DEFAULT_FROM_EMAIL, name: DEFAULT_FROM_NAME)

      personalization = SendGrid::Personalization.new
      personalization.add_to(SendGrid::Email.new(email: to_email, name: to_name))

      if Figaro.env.should_bcc_emails != "false"
        personalization.add_bcc(SendGrid::Email.new(email: BCC_ALL_MAIL_TO_EMAIL))
      end

      substitutions.each do |key, value|
        personalization.add_substitution(SendGrid::Substitution.new(key: key, value: value))
      end

      mail.template_id = template_id
      mail.add_personalization(personalization)

      client = SENDGRID_API_HANDLE.client.mail._("send")

      case Figaro.env.should_send_emails
        when "sandbox"
          mail.mail_settings = SendGrid::MailSettings.new.tap { |s| s.sandbox_mode = true }
        when "false"
          return
        end

      response = client.post(request_body: mail.to_json)
    end
  end
end
