# TODO: fetch products in 48-products-per-page batches. It's less suspicious.
class Product
  module Ulta
    class ProductEnumerator
      include Enumerable

      def each
        Product::Ulta::CategoryEnumerator.new.each do |category|
          page = category_page(category)

          page.css(".prod-title a").each do |product_url|
            relative_url = product_url.attribute("href").to_s
            yield Product::Ulta::ProductEntry.new(relative_url: relative_url)
          end
        end
      end

      private def category_page(category)
        Nokogiri::HTML(Product::Ulta::Client.fetch_category_page(category))
      end
    end
  end
end
