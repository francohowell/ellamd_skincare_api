##
# We define a thin layer around Koala for Facebook API interactions.
module Facebook
  def self.find_user(access_token:)
    Koala::Facebook::API
      .new(access_token, Figaro.env.facebook_app_secret!)
      .get_object("me", fields: "email,first_name,last_name")
  end
end
