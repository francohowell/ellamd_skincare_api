require "rails_helper"

describe Product::Ulta::CategoryEnumerator do
  subject { Product::Ulta::CategoryEnumerator.new }

  describe "#each" do
    it "returns Ulta categories" do
      skincare_root = File.read("#{Rails.root}/spec/support/product_pages/ulta-skincare-root.html")
      stub_request(:get, "https://www.ulta.com/skin-care?N=2707").to_return(body: skincare_root)

      cleansers_category = subject.find { |c| c.name == "Cleansers" }
      expect(cleansers_category&.id).to eq("2794")
      expect(cleansers_category&.url).to eq("https://www.ulta.com/skin-care-cleansers?N=2794")

      tools_category = subject.find { |c| c.name == "Tools" }
      expect(tools_category).to be_nil
    end
  end
end
