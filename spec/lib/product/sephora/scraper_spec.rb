require "rails_helper"

describe Product::Sephora::Scraper do
  let(:page) { File.read("#{Rails.root}/spec/support/product_pages/sephora-P309308.json") }
  let(:scraper) { Product::Sephora::Scraper.new(page: page) }

  describe "#valid?" do
    it "returns true when Product is valid" do
      scraper = Product::Sephora::Scraper.new(page: %Q[{"displayName": "Sodium laureth sulfate"}])
      expect(scraper.valid?).to be_truthy
    end

    it "returns false when Sephora API returns crap instead of valid json" do
      scraper = Product::Sephora::Scraper.new(page: "<!DOCTYPE html> Herp derp")
      expect(scraper.valid?).to be_falsey
    end

    it "returns false when Product name is blank" do
      scraper = Product::Sephora::Scraper.new(page: %Q[{
        "brand": {
          "displayName": "Procter & Gamble"
        }
      }])
      expect(scraper.valid?).to be_falsey
    end

    it "returns false when :errors field is present" do
      scraper = Product::Sephora::Scraper.new(page: %Q[{
        "name": "Sodium laureth sulfate",
        "errors": {
          "invalidInput": ["Sku is restricted for the specified country"]
        }
      }])

      expect(scraper.valid?).to be_falsey
    end
  end

  describe "#product_attributes" do
    it "returns correct Product attributes" do
      product_attributes = scraper.product_attributes

      expect(product_attributes[:store]).to eq("sephora")
      expect(product_attributes[:store_id]).to eq("P309308")
      expect(product_attributes[:brand]).to eq("Sunday Riley")
      expect(product_attributes[:name]).to eq("Good Genes All-In-One Lactic Acid Treatment")
      expect(product_attributes[:product_url]).to eq(
        "https://www.sephora.com/product/good-genes-all-in-one-lactic-acid-treatment-P309308"
      )
      expect(product_attributes[:image_url]).to eq(
        "https://www.sephora.com/productimages/sku/s1887298-main-zoom.jpg"
      )
      expect(product_attributes[:description]).to eq(
        "Good Genes All-In-One Lactic Acid Treatment is formulated with high potency, purified " \
        "grade lactic acid that immediately exfoliates dull, pore-clogging dead skin cells, "    \
        "revealing smoother, fresher, younger-looking skin. Fine lines appear visually plumped " \
        "while the skin looks more radiant.  With continued use, the appearance of stubborn "    \
        "hyperpigmentation and the visible signs of aging are reduced for a healthier-looking "  \
        "complexion. Perfect for all skin types and all ages, this treatment is enhanced with "  \
        "licorice for brightening, Good Genes clarifies, smooths, and retexturizes for instant " \
        "radiance."
      )
      expect(product_attributes[:diagnoses]).to eq(
        "- Dullness and uneven texture\n" \
        "- Dark spots\n"                  \
        "- Fine lines and wrinkles"
      )
      expect(product_attributes[:instructions]).to eq(
        "-Apply one to two pumps to clean skin.  \n"                                               \
        "Advanced tips:\n"                                                                         \
        "-Layer under Tidal Brightening Enzyme Water Cream to fight the appearance of stubborn "   \
        "hyperpigmentation.\n"                                                                     \
        "-Layer on top of Luna Sleeping Night Oil (or use Good Genes in the morning and Luna at "  \
        "night) for anti-aging radiance and the appearance of healthy, youthful-looking skin.  \n" \
        "-Can be applied under foundation as a radiance primer, without any oiliness.\n"           \
        "-Can be combined with Ceramic Slip (two pumps of Good Genes and one pump Ceramic Slip "   \
        "Clay Cleanser) for a \"Flash Facial\" mask.  \n"                                          \
        "-Leave on for one to 10 minutes for an immediately radiant, deep detox facial."
      )
      expect(product_attributes[:tags]).to eq(["Treatments", "Face Serums"])
      expect(product_attributes[:packages]).to contain_exactly(
        {
          "sku" => "1418581",
          "price" => 10500,
          "volume" => "1 oz/ 30 mL"
        },
        {
          "sku" => "1887298",
          "price" => 15800,
          "volume" => "1.7 oz/ 50 mL"
        }
      )
      expect(product_attributes[:average_rating]).to eq(4.3318)
      expect(product_attributes[:number_of_reviews]).to eq(1902)
      expect(product_attributes[:raw]).to be_present
    end
  end

  describe "#product_ingredients" do
    it "returns Array of ProductIngredient names" do
      expected = [
        "Opuntia Tuna Fruit (Prickly Pear) Extract",
        "Agave Tequilana Leaf (Blue Agave) Extract",
        "Cypripedium Pubescens (Lady's Slipper Orchid) Extract",
        "Opuntia Vulgaris (Cactus) Extract",
        "Aloe Barbadensis Leaf Extract & Saccharomyses Cerevisiae (Yeast) Extract",
        "Lactic Acid",
        "Caprylic/Capric Triglyceride",
        "Butylene Glycol",
        "Squalane",
        "Cyclomethicone",
        "Dimethicone",
        "Ppg-12/Smdi Copolymer",
        "Stearic Acid",
        "Cetearyl Alcohol And Ceteareth20",
        "Glyceryl Stearate And Peg-100 Stearate",
        "Arnica Montana (Flower) Extract",
        "Peg-75 Meadowfoam Oil",
        "Glycyrrhiza Glabra (Licorice) Root Extract",
        "Cymbopogon Schoenanthus (Lemongrass) Oil",
        "Triethanolamine",
        "Xantham Gum",
        "Phenoxyethanol",
        "Steareth-20",
        "Dmdm Hydantoin"
      ]

      expect(scraper.product_ingredients).to contain_exactly(*expected)
    end
  end
end
