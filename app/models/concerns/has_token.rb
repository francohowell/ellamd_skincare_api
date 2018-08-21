##
# Concern to manage a random `token` field on a model.
#
# This concern is used to give models a unique random token, currently of the form ELLAMD00000000,
# upon creation.
module HasToken
  extend ActiveSupport::Concern

  NUM_CHARACTERS_IN_TOKEN = 8

  included do
    before_create :generate_token
  end

  protected def generate_token
    self.token = loop do
      random_token = "ELLAMD" + (0..NUM_CHARACTERS_IN_TOKEN).map { ("0".."9").to_a.sample }.join("")
      break random_token unless self.class.exists?(token: random_token)
    end
  end
end
