require "rails_helper"

describe ProductsController do
  let(:admin) { administrators(:admin) }
  let(:good_genes_acid_treatment) { products(:good_genes_acid_treatment) }

  before do
    sign_in(admin)
  end

  describe "#index" do
    it "successfully renders list of Products and returns 200:success" do
      get :index, params: {"is_pending" => "t"}

      expect(response).to be_successful
      expect(json_response["products"]).to be_present
    end
  end

  describe "#sync" do
    it "successfully syncs Product and its ProductIngredients and returns it" do
      expect {
        post :sync, params: {
          "product" => {
            "id" => good_genes_acid_treatment.id.to_s,
            "brand" => "Herp-derp",
            "ingredients_string" => "Dimethicone, Linalool"
          }
        }
      }.to change{ProductIngredient.count}.by(2)

      good_genes_acid_treatment.reload
      expect(good_genes_acid_treatment.brand).to eq("Herp-derp")
      expect(good_genes_acid_treatment.product_ingredients.map(&:name)).to contain_exactly(*%w(Dimethicone Linalool))

      expect(response).to be_successful
      expect(json_response["product"]).to be_present
      expect(json_response.dig("product", "brand")).to eq("Herp-derp")
    end

    it "returns error when something goes wrong" do
      allow_any_instance_of(Product).to receive(:valid?).and_return(false)
      allow_any_instance_of(Product).to receive_message_chain(:errors, :full_messages).and_return(["surprise!"])

      post :sync, params: {
        "product" => {
          "id" => good_genes_acid_treatment.id.to_s,
          "brand" => "Herp-derp",
          "ingredients_string" => "Dimethicone, Linalool"
        }
      }

      expect(response).to be_successful
      expect(json_response["error"]).to eq("surprise!")
    end
  end
end
