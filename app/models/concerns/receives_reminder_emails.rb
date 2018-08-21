##
# Concern to manage various delayed reminder emails.
module ReceivesReminderEmails
  extend ActiveSupport::Concern

  SIGNUP_REMINDER_DELAY = 12.hours

  included do
    after_create :queue_signup_reminder_email
  end

  ##
  # Send a reminder email 12 hours after signup abandonment.
  #
  # This queues a job to check to see if the newly created user has a profile after a given delay
  # (`SIGNUP_REMINDER_DELAY`). If he or she doesn't, it sends an email.
  private def queue_signup_reminder_email
    delay(run_at: SIGNUP_REMINDER_DELAY.from_now)
      .send_signup_reminder_email_if_applicable
  end

  private def send_signup_reminder_email_if_applicable
    UserMailer.send_customer_incomplete_signup_reminder(self) if profile_empty?
  end
end
