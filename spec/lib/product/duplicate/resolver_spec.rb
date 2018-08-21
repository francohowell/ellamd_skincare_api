require "rails_helper"

describe Product::Duplicate::Resolver do
  subject { Product::Duplicate::Resolver.new }

  before do
    @sephora00 = FactoryBot.create(:product, store: "sephora", brand: "Belif", name: "Acid", number_of_reviews: 100)
    @sephora01 = FactoryBot.create(:product, store: "sephora", brand: "Belif", name: "Acid", number_of_reviews: 999)

    @sephora2 = FactoryBot.create(:product, store: "sephora", brand: "Murad", name: "Mask")
    @ulta2    = FactoryBot.create(:product, store: "ulta",    brand: "Murad", name: "Mask", origin: @sephora3)

    @ulta3      = FactoryBot.create(:product, store: "ulta",      brand: "Murad",  name: "Cleanser")
    @sephora3   = FactoryBot.create(:product, store: "sephora",   brand: "Murad",  name: "Cleanser")
    @dermstore3 = FactoryBot.create(:product, store: "dermstore", brand: "Murad",  name: "Cleanser")

    @sephora4 = FactoryBot.create(:product, store: "sephora", brand: "Belif", name: "Cleanser")
  end

  describe ".run" do
    it "goes through product duplicate sets and marks first product as origin, others as duplicates" do
      Product::Duplicate::Resolver.run

      [@sephora01, @sephora00, @sephora3, @ulta3, @sephora2, @dermstore3, @ulta2].each(&:reload)

      expect(@sephora00.origin).to  eq(@sephora01)
      expect(@sephora01.origin).to  be_nil

      expect(@sephora2.origin).to   be_nil
      expect(@ulta2.origin).to      eq(@sephora2)

      expect(@sephora3.origin).to   be_nil
      expect(@ulta3.origin).to      eq(@sephora3)
      expect(@dermstore3.origin).to eq(@sephora3)

      expect(@sephora4.origin).to   be_nil
    end
  end
end
