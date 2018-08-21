class Product
  module SearchIndex
    module_function

    def rebuild
      Product.without_duplicates
             .without_pending
             .includes(:product_ingredients)
             .reindex
    end
  end
end
