require "rails_helper"

describe Product::Sephora::ProductEnumerator do
  let(:page_enumerator) { Product::Sephora::ProductEnumerator.new }

  describe "#each" do
    it "yields Product IDs from Categories provided by CategoryEnumerator" do
      allow_any_instance_of(Product::Sephora::CategoryEnumerator).to receive(:each)
        .and_yield(Product::Sephora::CategoryEntry.new(id: "cat1230034"))
        .and_yield(Product::Sephora::CategoryEntry.new(id: "cat1230033"))

      cat1230034_page1 = File.read("#{Rails.root}/spec/support/product_pages/sephora-cat1230034-page1.json")
      stub_request(:get, "https://www.sephora.com/api/catalog/categories/cat1230034/products?currentPage=1&pageSize=300").to_return(body: cat1230034_page1)

      cat1230034_page2 = File.read("#{Rails.root}/spec/support/product_pages/sephora-cat1230034-page2.json")
      stub_request(:get, "https://www.sephora.com/api/catalog/categories/cat1230034/products?currentPage=2&pageSize=300").to_return(body: cat1230034_page2)

      cat1230033_page1 = File.read("#{Rails.root}/spec/support/product_pages/sephora-cat1230033-page1.json")
      stub_request(:get, "https://www.sephora.com/api/catalog/categories/cat1230033/products?currentPage=1&pageSize=300").to_return(body: cat1230033_page1)

      cat1230033_page2 = File.read("#{Rails.root}/spec/support/product_pages/sephora-cat1230033-page2.json")
      stub_request(:get, "https://www.sephora.com/api/catalog/categories/cat1230033/products?currentPage=2&pageSize=300").to_return(body: cat1230033_page2)

      expected = [
        "P427333",
        "P427348",
        "P427421"
      ]
      expect(page_enumerator.to_a.map(&:store_id)).to contain_exactly(*expected)
    end
  end
end
