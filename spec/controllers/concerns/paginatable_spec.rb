require "rails_helper"

describe Paginatable, type: :controller do
  let(:admin) { administrators(:admin) }

  before do
    sign_in(admin)
    @controller = CustomersController.new
  end

  describe "#render_with_pagination_meta" do
    it "renders collection and pagination meta" do
      get :index, params: {"page" => 1}

      expect(json_response).to be_kind_of(Hash)
      expect(json_response["customers"]).to be_kind_of(Array)
      expect(json_response["meta"]).to be_kind_of(Hash)
    end
  end

  describe "#pagination_meta" do
    it "returns meta information on pagination" do
      products = Product.page(1)
      meta = @controller.send(:pagination_meta, products)

      expect(meta[:current_page]).to eq(1)
      expect(meta[:total_pages]).to eq(1)
      expect(meta[:total_count]).to be_present
    end

    it "returns no meta if collection is not paginated" do
      products = Product.all
      meta = @controller.send(:pagination_meta, products)

      expect(meta).to be_nil
    end
  end
end
