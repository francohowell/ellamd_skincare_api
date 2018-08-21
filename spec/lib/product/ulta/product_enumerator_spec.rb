require "rails_helper"

describe Product::Ulta::ProductEnumerator do
  subject { Product::Ulta::ProductEnumerator.new }

  describe "#each" do
    it "yields Product Entries for given Ulta category" do
      allow_any_instance_of(Product::Ulta::CategoryEnumerator).to receive(:each)
        .and_yield(Product::Ulta::CategoryEntry.new(name: "Cleansers", url: "//www.ulta.com/skin-care-cleansers?N=2794"))
        .and_yield(Product::Ulta::CategoryEntry.new(name: "Moisturizers", url: "//www.ulta.com/skin-care-moisturizers?N=2796"))

      cleansers_root = File.read("#{Rails.root}/spec/support/product_pages/ulta-skincare-cleansers.html")
      stub_request(:get, "https://www.ulta.com/skin-care-cleansers?N=2794&No=0&Nrpp=5000").to_return(body: cleansers_root)

      moisturizers_root = File.read("#{Rails.root}/spec/support/product_pages/ulta-skincare-moisturizers.html")
      stub_request(:get, "https://www.ulta.com/skin-care-moisturizers?N=2796&No=0&Nrpp=5000").to_return(body: moisturizers_root)

      expected = [
        ["xlsImpprod11771009", "https://www.ulta.com/take-day-off-cleansing-balm?productId=xlsImpprod11771009"],
        ["xlsImpprod10791729", "https://www.ulta.com/liquid-facial-soap-mild?productId=xlsImpprod10791729"],
        ["xlsImpprod17611001", "https://www.ulta.com/bye-bye-foundation-full-coverage-moisturizer-with-spf-50?productId=xlsImpprod17611001"],
        ["xlsImpprod13641053", "https://www.ulta.com/confidence-in-a-cream-moisturizing-super-cream?productId=xlsImpprod13641053"]
      ]
      expect(subject.to_a.map { |product| [product.store_id, product.url] }).to contain_exactly(*expected)
    end
  end
end
