class Product
  module Sephora
    class CategoryEnumerator
      include Enumerable

      delegate :each, to: :categories

      def categories
        return @categories if @categories

        @categories = skincare_categories_entries.map do |category|
          Product::Sephora::CategoryEntry.new(
            id: category["categoryId"],
            name: category["displayName"],
            url: category["targetUrl"]
          )
        end
        @categories.reject! { |category_entry| category_entry.id == "cat60105" }
        @categories
      end

      private def skincare_categories_entries
        @skincare_category_entry ||= skincare_categories_pages.map do |page|
          JSON.parse(page)["childCategories"]
        end.flatten
      end

      private def skincare_categories_pages
        @skincare_categories_pages ||= Product::Sephora::Client.fetch_categories
      end
    end
  end
end
