class Product
  module Sokoglam
    class ProductEnumerator
      include Enumerable

      def each
        (1..number_of_index_pages).each do |idx|
          Product::Sokoglam::Client
            .fetch_index_page(idx)
            .yield_self { |page| Nokogiri::HTML(page) }
            .css(".product__info .yotpo")
            .each do |product|
              yield Product::Sokoglam::ProductEntry.new(
                store_id: product["data-product-id"],
                url: product["data-url"]
              )
            end
        end
      end

      private def number_of_index_pages
        Product::Sokoglam::Client
          .fetch_root_page
          .yield_self { |page| Nokogiri::HTML(page) }
          .css(".collection-pagination .page a")
          .last
          .inner_html
          .to_i
      end
    end
  end
end
