# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # List all domains that might access the API here.
    #
    # TODO: This should be broken out into a configuration item and specified per environment.
    origins "localhost:8080", "staging.ellamd.com", "my.ellamd.com", "ellamd.com"

    # Allow all resources to be accessed by the above, passing through the headers used by
    # DeviseTokenAuth to authenticate the user.
    resource "*",
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      headers: :any,
      expose: ["access-token", "expiry", "token-type", "uid", "client"],
      credentials: true
  end
end
