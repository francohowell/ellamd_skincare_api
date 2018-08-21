require "rails_helper"

describe My::MedicalProfileAuditsController do
  let(:ben_raspail) { customers(:ben_raspail) }

  before do
    sign_in(ben_raspail)
  end

  describe "#index" do
    it "returns 200:success and MedicalProfile audits" do
      ben_raspail.medical_profile.update_attributes!(is_pregnant: true)

      get :index

      expect(response).to be_successful
      expect(json_response["audits"].length).to eq(1)
    end
  end
end
