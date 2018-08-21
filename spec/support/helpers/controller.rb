module Helpers
  module Controller
    def sign_in(user)
      identity = user.identity
      request.headers.merge!(identity.create_new_auth_token)
    end

    def json_response
      @_json_response ||= JSON.parse(response.body)
    end
  end
end
