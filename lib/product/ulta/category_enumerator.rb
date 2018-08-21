class Product
  module Ulta
    class CategoryEnumerator
      include Enumerable

      delegate :each, to: :categories

      def categories
        return @categories if @categories

        @categories = categories_page.css(".cat-sub-nav a").map do |link_to_category|
          name = link_to_category.text
          url  = link_to_category.attribute("href").value

          Product::Ulta::CategoryEntry.new(
            name: name,
            url:  url
          )
        end

        @categories.reject! { |c| c.id == "2718" }

        @categories
      end

      private def categories_page
        @categories_page ||= Nokogiri::HTML(Product::Ulta::Client.fetch_categories_page)
      end
    end
  end
end
