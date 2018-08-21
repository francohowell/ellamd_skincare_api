class Product
  module Sokoglam
    class Scraper
      attr_reader :page, :raw_page

      def initialize(page:)
        @page = Nokogiri::HTML(page)
        @raw_page = page
      end

      def valid?
        true
      end

      def product_attributes
        {
          store: "sokoglam",
          store_id: store_id,
          brand: brand,
          name: name,
          product_url: product_url,
          image_url: image_url,
          description: description,
          diagnoses: nil,
          instructions: instructions,
          tags: tags,
          packages: packages,
          average_rating: average_rating,
          number_of_reviews: number_of_reviews,
          raw: {page: raw_page}
        }
      end

      def product_ingredients
        page
          .css("#full-ingredients span")
          .inner_html
          .split(/,\s/)
          .map { |ingredient| ingredient.strip }
      end

      # -----------------------------------------------------------------------
      # Product attributes
      private def store_id
        yotpo_main["data-product-id"]
      end

      private def brand
        page.css(".vendor a").inner_html
      end

      private def name
        microdata("name")
      end

      private def product_url
        microdata("url")
      end

      private def image_url
        microdata("image")
      end

      private def description
        page
          .css(".product-details .description")
          .children
          .map { |fragment| fragment.text.strip }
          .select { |fragment| fragment.present? }
          .join("\n")
      end

      private def instructions
        page
          .css("#how-to p")
          .map(&:text)
          .join("\n")
      end

      private def tags
        yotpo_bottom["data-bread-crumbs"]
          .split(";")
          .map { |tag| tag.strip }
      end

      private def packages
        # TODO
      end

      private def average_rating
        # TODO: calculate rating precisely based on
        #   data from .yotpo-distibutions-sum-reviews
        yotpo_main
          .css(".yotpo-stars-and-sum-reviews .yotpo-icon-star")
          .count
      end

      private def number_of_reviews
        yotpo_main
          .css(".yotpo-sum-reviews span")
          .inner_html
          .to_i
      end

      # -----------------------------------------------------------------------
      # Helper methods
      private def microdata(itemprop)
        page
          .css("main > [itemscope]")[0]
          .css(%Q([itemprop="#{itemprop}"]))[0]["content"]
      end

      private def yotpo_main
        @yotpo_main ||= page.css(".yotpo-main-widget")[0]
      end

      private def yotpo_bottom
        @yotpo_bottom ||=
          page.css(%(.yotpo.bottomLine[data-product-id="#{store_id}"]))[0]
      end
    end
  end
end
