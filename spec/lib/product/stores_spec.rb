require "rails_helper"

describe Product::Stores do
  describe "Stores" do
    it "is a list of Product::Store" do
      result = Product::Stores.all? { |store| store.is_a?(Product::Store) }
      expect(result).to be_truthy
    end

    it "has ID set for each Product::Store" do
      sephora_store = Product::Stores.find { |store| store.name == "sephora" }
      expect(sephora_store.id).to be_present
    end
  end
end
