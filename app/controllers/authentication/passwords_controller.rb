##
# We override the default DeviseTokenAuth password controller for better control over the response
# formats.
class Authentication::PasswordsController < DeviseTokenAuth::PasswordsController
  def create
    unless params[:email].to_s.match?(/@/)
      render json: {error: "Email is invalid"}
      return
    end

    @redirect_url = params[:redirect_url] || DeviseTokenAuth.default_password_reset_url
    @email        = params[:email].to_s.downcase
    @identity     = Identity.find_by_email(@email)

    case @identity&.provider
    when nil
      # Do nothing, @identity with given email does not exist
    when "email"
      @identity.send_reset_password_instructions(redirect_url: @redirect_url)
      raise "Failed to send reset password instructions" if @identity.errors.present?
    when "facebook", "google"
      UserMailer.send_email(user: @identity.user, template: :forgot_password_3rd_party_provider)
    else
      raise "Unknown identity provider: #{@identity&.provider}"
    end

    render_okay
  end

  def update
    @identity = Identity.reset_password_by_token(reset_password_token: params[:token])

    if @identity.id.nil?
      return render json: {error: "Your password reset link is invalid"}
    end

    @identity.update!(password: params[:password])

    render json: @identity, meta: {token: @identity.create_new_auth_token}
  end

  private def render_okay
    render json: {message: "Okay"}
  end
end
