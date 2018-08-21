require "rails_helper"

describe Product::Ulta::Scraper do
  let(:page) { File.read("#{Rails.root}/spec/support/product_pages/ulta-skincare-liquid-facial-soap.html") }
  let(:scraper) { Product::Ulta::Scraper.new(
    store_id: "xlsImpprod10791729",
    url: "https://www.ulta.com/liquid-facial-soap-mild?productId=xlsImpprod10791729",
    page: page
  ) }

  describe "#product_attributes" do
    it "returns correct Product attributes" do
      price_2265451 = File.read("#{Rails.root}/spec/support/product_pages/ulta-price-2265451.html")
      stub_request(:get, "https://www.ulta.com/common/inc/productDetail_price.jsp?productId=xlsImpprod10791729&skuId=2265451&fromPDP=true").to_return(body: price_2265451)

      price_2153910 = File.read("#{Rails.root}/spec/support/product_pages/ulta-price-2153910.html")
      stub_request(:get, "https://www.ulta.com/common/inc/productDetail_price.jsp?productId=xlsImpprod10791729&skuId=2153910&fromPDP=true").to_return(body: price_2153910)

      product_attributes = scraper.product_attributes

      expect(product_attributes[:store]).to eq("ulta")
      expect(product_attributes[:store_id]).to eq("xlsImpprod10791729")
      expect(product_attributes[:brand]).to eq("Clinique")
      expect(product_attributes[:name]).to eq("Liquid Facial Soap - Mild")
      expect(product_attributes[:product_url]).to eq(
        "https://www.ulta.com/liquid-facial-soap-mild?productId=xlsImpprod10791729"
      )
      expect(product_attributes[:image_url]).to eq(
        "https://images.ulta.com/is/image/Ulta/2153910?$detail$"
      )

      expect(product_attributes[:description]).to eq(
        "Clinique's Liquid Facial Soap Extra Mild is Step 1 in their customized 3-Step Skin "      \
        "Care System. Dermatologist-developed Liquid Facial Soap Extra Mild cleanses gently yet "  \
        "thoroughly. For dry combination skin.\n"                                                  \
        "\n"                                                                                       \
        "The secret's in the system. Their revolutionary 3-Step Skin Care System was created by "  \
        "a celebrated dermatologist. It's simple, customized and takes just three minutes, twice " \
        "a day: cleanse with Facial Soap, exfoliate with Clarifying Lotion, moisturize with "      \
        "Dramatically Different Moisturizing Lotion+.\n"                                           \
        "\n"                                                                                       \
        "Features and Benefits:\n"                                                                 \
        "- Soft, non-drying lather loosens surface flakes, removes dirt and debris, and protects " \
        "skin's natural moisture balance\n"                                                        \
        "- Quick-rinsing formula leaves skin clean, comfortable, refreshed - never taut or dry\n"  \
        "- Preps skin for the exfoliating action of Step 2, Clarifying Lotion\n"                   \
        "\n"                                                                                       \
        "\n"                                                                                       \
        "Formula Facts:\n"                                                                         \
        "- Allergy tested\n"                                                                       \
        "- 100% fragrance free\n"                                                                  \
        "- Dermatologist developed\n"                                                              \
        "- Oil free\n"                                                                             \
        "- Paraben Free"
      )

      expect(product_attributes[:diagnoses]).to be_nil
      expect(product_attributes[:instructions]).to eq(
        "- Use twice a day, morning and night\n"    \
        "- Lather between palms with tepid water\n" \
        "- Massage over makeup-free face\n"         \
        "- Rinse thoroughly; pat skin dry\n"        \
        "- Follow with Steps 2 and 3: Clarifying Lotion and Dramatically Different Moisturizing Lotion+"
      )
      expect(product_attributes[:tags]).to eq(["Cleansers", "Face Wash"])
      expect(product_attributes[:packages]).to contain_exactly(
        {
          "sku"    => "2265451",
          "price"  => 1450,
          "volume" => "5.0 oz"
        },
        {
          "sku"    => "2153910",
          "price"  => 1750,
          "volume" => "6.7 oz"
        }
      )
      expect(product_attributes[:average_rating]).to eq(4.8)
      expect(product_attributes[:number_of_reviews]).to eq(624)
      expect(product_attributes[:raw]).to be_present
    end
  end

  describe "#product_ingredients" do
    it "returns Array of ProductIngredient names" do
      expected = [
        "Water / Aqua / Eau",
        "Sodium Laureth Sulfate",
        "Sodium Chloride",
        "Cocamidopropyl Hydroxysultaine",
        "Lauramidopropyl Betaine",
        "Sodium Cocoyl Sarcosinate",
        "Tea-Cocoyl Glutamate",
        "Di-PPG-2 Myreth-10 Adipate",
        "Aloe Barbadensis Leaf Juice",
        "PEG-120 Methyl Glucose Dioleate",
        "Sucrose",
        "Sodium Hyaluronate",
        "Cetyl Triethylmonium Dimethicone PEG-8 Succinate",
        "Butylene Glycol",
        "Hexylene Glycol",
        "Polyquaternium-7",
        "Laureth-2",
        "Caprylyl Glycol",
        "Sodium Sulfate",
        "Tocopheryl Acetate",
        "EDTA",
        "Disodium EDTA",
        "Phenoxyethanol"
      ]

      expect(scraper.product_ingredients).to contain_exactly(*expected)
    end
  end
end
