##
# We override the default DeviseTokenAuth session controller for better control over the response
# formats and to add a method for the UI to request the current Identity.
class Authentication::SessionsController < DeviseTokenAuth::SessionsController
  ##
  # Render the current Identity as well as a new authentication token/headers.
  #
  # This is called by DeviseTokenAuth on a successful authentication; `@resource` is the logged-in
  # Identity.
  def render_create_success
    render json: @resource, meta: {token: @resource.create_new_auth_token}
  end

  ##
  # Render a warning about bad credentials.
  #
  # This is called by DeviseTokenAuth on an unsuccessful authentication.
  def render_create_error_bad_credentials
    render json: {error: "Those credentials weren't recognized"}
  end

  ##
  # Endpoint to retreive the current logged-in Identity.
  #
  # This is used to initialize the Identity in the UI.
  def current
    return render_not_authorized unless current_identity
    render json: current_identity
  end

  ##
  # We override Devise's `create` so we can catch Facebook logins.
  def create
    if params[:provider] == "facebook"
      facebook_user = Facebook.find_user(access_token: params[:facebook_access_token])
      @resource = Identity.find_by(uid: facebook_user["uid"], provider: "facebook")
    end

    if @resource
      render_create_success
    else
      super
    end
  end
end
