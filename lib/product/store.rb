class Product
  class Store
    attr_reader :id, :name, :product_enumerator, :scraper

    def initialize(id:, name:, product_enumerator:, scraper:)
      @id = id
      @name = name
      @product_enumerator = product_enumerator
      @scraper = scraper
    end
  end
end
