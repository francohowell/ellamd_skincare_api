
module SendGridMailSettingsHacks
  def sandbox_mode
    @sandbox_mode.nil? ? nil : {"enable": @sandbox_mode}
  end
end

SendGrid::MailSettings.prepend(SendGridMailSettingsHacks)
