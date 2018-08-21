class Product
  module Sephora
    class Client < Product::HttpClient
      def self.fetch_categories
        skincare_url     = "https://www.sephora.com/api/catalog/categories/cat150006"
        men_skincare_url = "https://www.sephora.com/api/catalog/categories/cat1230058"

        Rails.logger.debug "[Sephora] Fetching categories..."
        skincare_page     = http_client.get(skincare_url).body.to_s
        men_skincare_page = http_client.get(men_skincare_url).body.to_s
        Rails.logger.debug "[Sephora] Fetching categories has finished"

        [skincare_page, men_skincare_page]
      end

      def self.fetch_category_products(category:, page:)
        category_url = "https://www.sephora.com/api/catalog/categories/#{category.id}"
        page_size    = 300
        url          = "#{category_url}/products?currentPage=#{page}&pageSize=#{page_size}"

        Rails.logger.debug "[Sephora] Fetching page #{page} of category #{category.name}..."
        text_response = http_client.get(url).body.to_s
        Rails.logger.debug "[Sephora] Fetching page #{page} of category #{category.name} has finished"

        JSON.parse(text_response)["products"]
      rescue
        raise "[Sephora] Fetching page #{page} of category #{category.name} has failed"
      end

      def self.fetch_product_page(store_id:)
        url = "https://www.sephora.com/api/catalog/products/#{store_id}"

        Rails.logger.debug "[Sephora] Fetching product ##{store_id} from url #{url}..."
        result = http_client.get(url).body.to_s
        Rails.logger.debug "[Sephora] Fetching product ##{store_id} has finished"

        result
      end
    end
  end
end
