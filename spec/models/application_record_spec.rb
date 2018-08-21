require "rails_helper"

describe ApplicationRecord do
  describe "#error_message" do
    it "returns string with comma-separated error messages" do
      identity = Identity.new

      expect(identity.save).to be_falsey
      expect(identity.error).to match("First name")
      expect(identity.error).to match("Last name")
    end
  end
end
