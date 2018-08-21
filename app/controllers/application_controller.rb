class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Paginatable
  include Rescues
  include SetObjectsFromParams
  include ProvideSegmentHooks

  ##
  # Set the `@current_policy` instance variable to our access policy.
  #
  # This is called by AccessGranted to find the access policy for the request. There's currently
  # only one policy, defined in `/app/policies/access_policy.rb`. We override the default
  # AccessGranted implementation of this method because it looks for `current_user` (which doesn't
  # work as our Devise model is Identity).
  def current_policy
    @current_policy ||= ::AccessPolicy.new(current_identity)
  end
end
