require "rails_helper"

describe Product::Sephora::CategoryEnumerator do
  let(:category_enumerator) { Product::Sephora::CategoryEnumerator.new }

  describe "#each" do
    it "returns all categories as Name-URL pairs" do
      skincare_root = File.read("#{Rails.root}/spec/support/product_pages/sephora-cat150006.json")
      stub_request(:get, "https://www.sephora.com/api/catalog/categories/cat150006").to_return(body: skincare_root)

      men_skincare_root = File.read("#{Rails.root}/spec/support/product_pages/sephora-cat1230058.json")
      stub_request(:get, "https://www.sephora.com/api/catalog/categories/cat1230058").to_return(body: men_skincare_root)

      cleansers_category = category_enumerator.find { |c| c.name == "Cleansers" }
      expect(cleansers_category&.id).to eq("cat1230033")
      expect(cleansers_category&.url).to eq("/shop/cleanser")

      # Filter out root "Skincare" category
      # Filter out level 2+ subcategories, Products that belong to them can be found in
      #   parent level-1 category
      # Filter out "Value & Gift Sets" category which contains multiple Products bundled together
      expect(category_enumerator.find { |c| c.name == "Skincare" }).to be_nil
      expect(category_enumerator.find { |c| c.name == "Toners" }).to be_nil
      expect(category_enumerator.find { |c| c.name == "Value & Gift Sets" }).to be_nil
    end
  end
end
