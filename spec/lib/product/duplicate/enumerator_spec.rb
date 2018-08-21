require "rails_helper"

describe Product::Duplicate::Enumerator do
  subject { Product::Duplicate::Enumerator.new }

  before do
    @sephora00 = FactoryBot.create(:product, store: "sephora", brand: "Belif", name: "Acid", number_of_reviews: 100)
    @sephora01 = FactoryBot.create(:product, store: "sephora", brand: "Belif", name: "Acid", number_of_reviews: 999)

    @sephora2 = FactoryBot.create(:product, store: "sephora", brand: "Murad", name: "Mask")
    @ulta2    = FactoryBot.create(:product, store: "ulta",    brand: "Murad", name: "Mask", origin: @sephora3)

    @ulta3    = FactoryBot.create(:product, store: "ulta",    brand: "Murad",  name: "Cleanser")
    @sephora3 = FactoryBot.create(:product, store: "sephora", brand: "Murad",  name: "Cleanser")

    @sephora4 = FactoryBot.create(:product, store: "sephora", brand: "Belif", name: "Cleanser")
  end

  describe "#each" do
    it "yields arrays of duplicates across different stores" do
      expected = [
        [@sephora01, @sephora00],
        [@sephora3, @ulta3],
        [@sephora2, @ulta2]
      ]

      expect(subject.to_a).to contain_exactly(*expected)
    end
  end

  describe "#ordered_product_ids" do
    it "returns ids of Products that have a duplicate" do
      expected = [@sephora01, @sephora00, @sephora3, @ulta3, @sephora2, @ulta2].map(&:id)
      expect(subject.send(:ordered_product_ids)).to eq(expected)
    end
  end

  describe "#ordered_products" do
    it "returns all Products that have a duplicate" do
      expected = [@sephora01, @sephora00, @sephora3, @ulta3, @sephora2, @ulta2]
      expect(subject.send(:ordered_products)).to eq(expected)
    end
  end
end
