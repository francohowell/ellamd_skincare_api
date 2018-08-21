# In Rails, you could put this in config/initializers/koala.rb
Koala.configure do |config|
  config.app_id = Figaro.env.facebook_app_id!
  config.app_secret = Figaro.env.facebook_app_secret!
end
