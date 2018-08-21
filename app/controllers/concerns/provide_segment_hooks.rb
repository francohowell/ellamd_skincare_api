##
# Concern to provide hooks into the Segment analytics service.
#
# This allows us to identify the current user (if there is one) with Segment on every request, as
# well as provide some useful tracking aliases.
module ProvideSegmentHooks
  extend ActiveSupport::Concern

  included do
    before_action :identify_with_segment
  end

  public def track(event_name, properties = {}, user_or_identity = nil)
    if user_or_identity
      identity = user_or_identity.is_a?(Identity) ? user_or_identity : user_or_identity.identity
      @user_id = identity&.id
    else
      @user_id = current_identity&.id
    end

    return unless @user_id

    Analytics.track(
      user_id: @user_id,
      event: event_name,
      properties: properties,
    )
  end

  private def identify_with_segment
    return unless current_identity

    Analytics.identify(
      user_id: current_identity.id,
      traits: {
        name: current_identity.full_name,
        email: current_identity.email,
        type: current_identity.user_type,
      },
    )
  end
end
