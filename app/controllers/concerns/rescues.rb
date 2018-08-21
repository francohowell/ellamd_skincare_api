##
# Concern to patch in handling of various exceptions at the ApplicationController level.
#
# This concern defines a bunch of protected methods to render various errors. It uses Rails's
# `rescue_from` to catch various exceptions before they bubble up out of the app. These errors are
# not meant to be recovered from at this point (that should happen lower down if it's possible);
# rather, this concern allows us to send a meaningful (and correctly formatted) response to the UI.
module Rescues
  extend ActiveSupport::Concern

  included do
    rescue_from Exceptions::ApplicationError, with: :render_error
    rescue_from AccessGranted::AccessDenied, with: :render_not_authorized
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveModel::ValidationError, with: :render_validation_error
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_error
    rescue_from Twilio::REST::RestError, with: :render_twilio_error
  end

  protected def render_not_authorized
    render json: {error: "You are not authorized to do that"}
  end

  protected def render_not_found
    render json: {error: "Not found"}
  end

  protected def render_validation_error(error)
    render json: {error: error.model.errors.to_a.join("; ")}
  end

  protected def render_record_error(error)
    render json: {error: error.record.errors.to_a.join("; ")}
  end

  protected def render_twilio_error(error)
    render json: {error: error.message}
  end

  protected def render_error(error)
    render json: {error: error.message}
  end
end
