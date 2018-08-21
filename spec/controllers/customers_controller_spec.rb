require "rails_helper"

describe CustomersController do
  let(:admin) { administrators(:admin) }
  let(:ben_raspail) { customers(:ben_raspail) }

  context "as Admin" do
    before do
      sign_in(admin)
    end

    describe "#index" do
      it "returns list of Customers and 200:success" do
        get :index

        expect(response).to be_successful
        expect(json_response["customers"]).to be_present
      end
    end

    describe "#show" do
      it "returns Customer and 200:success" do
        get :show, params: {id: ben_raspail.id}

        expect(response).to be_successful
        expect(json_response["customer"]).to be_present
      end
    end
  end

  context "as Customer" do
    before do
      sign_in(ben_raspail)
    end

    describe "#update" do
      it "updates Customer, its Identity and its MedicalProfile and returns 200:success" do
        post :update, params: {
          "customer_id" => ben_raspail.id,
          "first_name"  => "Rainbow Dash",
          "city"        => "Ponyville",
          "medical_profile" => {
            "is_smoker"   => "... and not only tobacco"
          }
        }

        ben_raspail.reload

        expect(response).to be_successful
        expect(ben_raspail.identity.first_name).to eq("Rainbow Dash")
        expect(ben_raspail.city).to eq("Ponyville")
        expect(ben_raspail.medical_profile.is_smoker).to eq("... and not only tobacco")
      end
    end
  end
end
