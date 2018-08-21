class Product
  module Ulta
    class ProductEntry
      BASE_URL = "https://www.ulta.com"

      attr_reader :url

      delegate :eligible_for_update?, to: :database_entry

      def initialize(relative_url:)
        self.relative_url = relative_url
      end

      def store_id
        @store_id ||= Addressable::URI.parse(url).query_values["productId"]
      end

      def update!
        database_entry.update_attributes!(remote_entry.product_attributes)
        database_entry.update_ingredients!(remote_entry.product_ingredients)
      end

      private def relative_url=(relative_url)
        @id  = nil
        @url = "#{BASE_URL}#{relative_url}"
      end

      private def database_entry
        @database_entry ||= Product.find_or_initialize_by(
          store: "ulta",
          store_id: store_id
        )
      end

      private def remote_entry
        @remote_entry ||= Product::Ulta::Scraper.new(
          store_id: store_id,
          url: url,
          page: remote_entry_page
        )
      end

      private def remote_entry_page
        @remote_entry_page ||= Product::Ulta::Client.fetch_product_page(self)
      end
    end
  end
end
