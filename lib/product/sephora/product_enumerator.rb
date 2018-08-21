class Product
  module Sephora
    class ProductEnumerator
      include Enumerable

      def each
        Product::Sephora::CategoryEnumerator.new.each do |category|
          page = 0

          begin
            page += 1

            product_entries = Product::Sephora::Client.fetch_category_products(
              category: category,
              page: page
            )

            product_entries.each do |product_entry|
              yield Product::Sephora::ProductEntry.new(store_id: product_entry["productId"])
            end

          end while product_entries.present?
        end
      end
    end
  end
end
