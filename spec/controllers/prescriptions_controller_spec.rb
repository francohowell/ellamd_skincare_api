require "rails_helper"

describe PrescriptionsController do
  let(:admin) { administrators(:admin) }
  let(:prescription) { prescriptions(:ben_raspail_previous_visit_prescription) }
  let(:prescription_action_token) { ActionToken.create(owner: admin.identity, tokenable: prescription) }

  before do
    sign_in(admin)
  end

  describe "#index" do
    it "returns Prescriptions" do
      get :index, params: {"sort-column" => "created-at", "sort-ascending" => "false"}

      expect(response).to be_successful
      expect(json_response["prescriptions"]).to be_present
      expect(json_response["meta"]).to be_present
    end
  end

  describe "#prescription_pdf" do
    it "renders pdf and returns http:success" do
      get :prescription_pdf, params: {
        prescription_token: prescription.token,
        action_token: prescription_action_token.token
      }

      expect(response).to be_successful
    end
  end
end
