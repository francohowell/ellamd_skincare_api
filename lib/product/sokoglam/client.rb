class Product
  module Sokoglam
    class Client < Product::HttpClient
      def self.fetch_root_page
        url = "https://sokoglam.com/collections/skincare"

        Rails.logger.debug "[Sokoglam] Fetching product root page..."
        result = http_client.get(url).body.to_s
        Rails.logger.debug "[Sokoglam] Fetching product root page has finished"

        result
      end

      def self.fetch_index_page(idx)
        url = "https://sokoglam.com/collections/skincare?page=#{idx}"

        Rails.logger.debug "[Sokoglam] Fetching product index page #{idx}..."
        result = http_client.get(url).body.to_s
        Rails.logger.debug "[Sokoglam] Fetching product index page #{idx} has finished"

        result
      end

      def self.fetch_product_page(url)
        Rails.logger.debug "[Sokoglam] Fetching product page #{url}..."
        $browser ||= Product::Browser.new
        $browser.navigate_to(url)
        result = $browser.page_source
        Rails.logger.debug "[Sokoglam] Fetching product page #{url} has finished"

        result
      end
    end
  end
end
