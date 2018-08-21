require "rails_helper"

describe Product::Sokoglam::Scraper do
  let(:page) {
    File.read("#{Rails.root}/spec/support/product_pages/sokoglam-triple-c-lightning-liquid.html")
  }
  let(:scraper) { Product::Sokoglam::Scraper.new(
    # store_id: "xlsImpprod10791729",
    # url: "https://www.ulta.com/liquid-facial-soap-mild?productId=xlsImpprod10791729",
    page: page
  ) }

  describe "#product_attributes" do
    it "returns correct Product attributes" do
      product_attributes = scraper.product_attributes

      expect(product_attributes[:store]).to eq("sokoglam")
      expect(product_attributes[:store_id]).to eq("8934600265")
      expect(product_attributes[:brand]).to eq("COSRX")
      expect(product_attributes[:name]).to eq("Triple C Lightning Liquid")
      expect(product_attributes[:product_url]).to eq(
        "https://sokoglam.com/products/cosrx-triple-c-lightning-liquid"
      )
      expect(product_attributes[:image_url]).to eq(
        "http://cdn.shopify.com/s/files/1/0249/1218/products/COSRX-Triple-C-Lightning-Liquid-New-Packaging-2_grande.jpg?v=1527084174"
      )
      expect(product_attributes[:description]).to match(
        "An exclusive collaboration"
      )
      expect(product_attributes[:diagnoses]).to be_nil
      expect(product_attributes[:instructions]).to eq(
        "If you’re new to acids or have sensitive skin, start by mixing 2-3 drops in your moisturizer and applying onto your face every night. If you see no signs of irritation after two weeks, apply 1-2 drops directly onto your skin every other night, always following with a hydrating moisturizer. Gradually work your way up to applying the serum every night. This Vitamin C serum is recommended as a night treatment. If used before sun exposure, make sure to apply sunscreen.\n" \
        "Triple C Lightning Liquid is a highly concentrated serum with pure Vitamin C, so your skin may feel sensitive or tingly upon application.For more information on how to store Vitamin C and other skin care tips, please visit The Klog."
      )
      expect(product_attributes[:tags]).to eq([
          "acne",
        "anti-aging",
        "badge-bestofkbeauty",
        "badge-peoplesaward",
        "badge-xocharlotte",
        "charlotte cho",
        "combination",
        "cosrx",
        "dry",
        "fragrance free",
        "normal",
        "oily",
        "oily kin",
        "pigmentation",
        "serum",
        "vitamin c"
      ])
      # expect(product_attributes[:packages]).to contain_exactly(
      #   {
      #     "sku"    => "31557651529",
      #     "price"  => 2700,
      #     "volume" => "5.0 oz"
      #   }
      # )
      expect(product_attributes[:average_rating]).to eq(4) # 4.06
      expect(product_attributes[:number_of_reviews]).to eq(645)
      expect(product_attributes[:raw]).to be_present
    end
  end

  describe "#product_ingredients" do
    it "returns Array of ProductIngredient names" do
      expected = [
        "Aronia Melanocarpa fruit extract (Black Chokeberry)",
        "Ascorbic acid (Vitamin C)",
        "Butylene glycol",
        "Sodium lactate",
        "Licorice root extract",
        "1,2- Hexanediol",
        "Pullulan",
        "Sodium hyaluronate",
        "Cassia obtusifolia seed extract",
        "Allantoin"
      ]

      expect(scraper.product_ingredients).to contain_exactly(*expected)
    end
  end
end
