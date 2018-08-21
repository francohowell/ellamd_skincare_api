class Product
  module Sokoglam
    class ProductEntry
      attr_reader :store_id, :url

      delegate :eligible_for_update?, to: :database_entry
      delegate :valid?, to: :remote_entry

      def initialize(store_id:, url:)
        @store_id = store_id
        @url = url
      end

      def update!
        database_entry.update_attributes!(remote_entry.product_attributes)
        database_entry.update_ingredients!(remote_entry.product_ingredients)
      end

      private def database_entry
        @database_entry ||= Product.find_or_initialize_by(
          store: "sokoglam",
          store_id: store_id
        )
      end

      private def remote_entry
        @remote_entry ||= Product::Sokoglam::Scraper.new(page: remote_page)
      end

      private def remote_page
        @remote_entry_page ||=
          Product::Sokoglam::Client.fetch_product_page(url)
      end
    end
  end
end
