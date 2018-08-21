class Product
  Stores = [
    Store.new(
      id: 1,
      name: "sephora",
      product_enumerator: Product::Sephora::ProductEnumerator,
      scraper: Product::Sephora::Scraper
    ),
    Store.new(
      id: 2,
      name: "ulta",
      product_enumerator: Product::Ulta::ProductEnumerator,
      scraper: Product::Ulta::Scraper
    ),
    # Scraper #3 is dermstore
    Store.new(
      id: 4,
      name: 'sokoglam',
      product_enumerator: Product::Sokoglam::ProductEnumerator,
      scraper: Product::Sokoglam::Scraper
    )
  ]
end
