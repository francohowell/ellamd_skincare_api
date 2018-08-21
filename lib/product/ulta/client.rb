class Product
  module Ulta
    class Client < Product::HttpClient
      MAX_PRODUCTS_PER_CATEGORY = 5000

      def self.fetch_categories_page
        url = "https://www.ulta.com/skin-care?N=2707"

        Rails.logger.debug "[Ulta] Fetching list of categories..."
        result = http_client.get(url).body.to_s
        Rails.logger.debug "[Ulta] Fetching list of categories has finished"

        result
      end

      def self.fetch_category_page(category)
        url = "#{category.url}&No=0&Nrpp=#{MAX_PRODUCTS_PER_CATEGORY}"

        Rails.logger.debug "[Ulta] Fetching list of products from category #{category.name}..."
        result = http_client.get(url).body.to_s
        Rails.logger.debug "[Ulta] Fetching list of products from category #{category.name} has finished"

        result
      end

      def self.fetch_product_page(product)
        Rails.logger.debug "[Ulta] Fetching product #{product.store_id}..."
        result = http_client.get(product.url).body.to_s
        Rails.logger.debug "[Ulta] Fetching product #{product.store_id} has finished"

        result
      end

      def self.fetch_product_price_partial(store_id:, sku:)
        Rails.logger.debug "[Ulta] Fetching price of product #{store_id}, sku #{sku}..."

        url = "https://www.ulta.com/common/inc/productDetail_price.jsp?productId=#{store_id}&skuId=#{sku}&fromPDP=true"
        result = http_client.get(url).body.to_s
        Rails.logger.debug "[Ulta] Fetching price of product #{store_id}, sku #{sku} has finished"

        result
      end
    end
  end
end
