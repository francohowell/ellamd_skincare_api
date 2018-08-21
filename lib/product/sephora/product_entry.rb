class Product
  module Sephora
    class ProductEntry
      attr_reader :store_id

      delegate :eligible_for_update?, to: :database_entry
      delegate :valid?, to: :remote_entry

      def initialize(store_id: nil)
        @store_id = store_id
      end


      def update!
        database_entry.update_attributes!(remote_entry.product_attributes)
        database_entry.update_ingredients!(remote_entry.product_ingredients)
      end

      private def database_entry
        @database_entry ||= Product.find_or_initialize_by(
          store: "sephora",
          store_id: store_id
        )
      end

      private def remote_entry
        @remote_entry ||= Product::Sephora::Scraper.new(page: remote_page)
      end

      private def remote_page
        @remote_entry_page ||= Product::Sephora::Client.fetch_product_page(store_id: store_id)
      end
    end
  end
end
