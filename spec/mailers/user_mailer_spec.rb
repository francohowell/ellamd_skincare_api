require "rails_helper"

describe UserMailer do
  let(:ben_raspail) { customers(:ben_raspail) }
  let(:hannibal_lecter) { physicians(:hannibal_lecter) }

  describe ".send_email" do
    it "sends email to the User" do
      VCR.use_cassette("UserMailer.send_email") do
        UserMailer.send_email(user: ben_raspail, template: :recurring_visit_created)
        expect(VCR.last_interaction.response.status.code).to eq(200)
      end
    end
  end

  describe ".common_user_substitutions" do
    it "substitutes common variables" do
      result = UserMailer.send(:common_user_substitutions, hannibal_lecter)["%first_name%"]
      expect(result).to eq("Hannibal")
    end

    it "substitutes Customer variables" do
      result = UserMailer.send(:common_user_substitutions, ben_raspail)["%provider%"]
      expect(result).to eq("Email")
    end
  end
end
