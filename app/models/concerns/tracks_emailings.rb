##
# Concern to group together Emailing tracking.
#
# This is mostly just used for logging which emails we send to which users when. It's included on
# Identity and provides some useful query methods.
module TracksEmailings
  extend ActiveSupport::Concern

  included do
    has_many :emailings
  end

  ##
  # Has the Identity ever received the given `template_id`?
  def email_template_sent?(template_id)
    emailings.where(template_id: template_id).any?
  end

  ##
  # Has the Identity received the given `template_id` since `time`?
  def email_template_sent_since?(template_id, time)
    emailings.where(template_id: template_id)
      .pluck(:created_at)
      .any? { |created_at| created_at > time }
  end
end
