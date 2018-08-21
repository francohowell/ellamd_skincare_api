class Product
  module Ulta
    class Scraper
      attr_reader :store_id, :url, :page, :raw_page

      def initialize(store_id:, url:, page:)
        @store_id = store_id
        @url      = url
        @page     = Nokogiri::HTML(page)
        @raw_page = page
      end

      def valid?
        return false if raw_page.match?(/Access\ Denied/)
        return false if raw_page.match?(/Application\ Firewall\ Error/)

        true
      end

      def product_attributes
        {
          store: "ulta",
          store_id: store_id,
          brand: brand,
          name: name,
          product_url: url,
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

      # TODO: extract part before <br>
      def product_ingredients
        css_element_value(".current-ingredients")
          .partition("Please be aware")[0]
          .split(",")
          .map { |x| x.strip.tr(".", "") }
          .select { |x| x.present? }
      end

      ###
      # Product attributes
      private def brand
        css_element_value(%Q|[itemprop="brand"]|)
      end

      private def name
        css_element_value(%Q|[itemprop="name"]|)
      end

      private def image_url
        skus.values.first["imgUrl"]
      end

      private def description
        css_element_value(".current-longDescription")
          .split("\n")
          .reject { |x| x.match?("Click here") }
          .join("\n")
          .strip
      end

      private def instructions
        css_element_value(".current-directions")
      end

      private def tags
        page.css(".makeup-breadcrumb a[data-nav-description]")
            .map { |x| x.text }[2..-1]
      end

      private def packages
        js_variable_value("productSkus").map do |sku, package|
          {
            "sku"    => sku,
            "volume" => package["displayName"],
            "price"  => price(sku: sku)
          }
        end
      end

      private def average_rating
        css_element_value(".pr-rating.pr-rounded.average").to_f
      end

      private def number_of_reviews
        css_element_value(".pr-snapshot-average-based-on-text")[/\d+/].to_i
      end

      ###
      # Helper methods
      private def price(sku:)
        text = Product::Ulta::Client.fetch_product_price_partial(store_id: store_id, sku: sku)
        html = Nokogiri::HTML.fragment(text)
        raw_price = html.css("label")[0].next_sibling.text

        price_in_dollars = raw_price[/[\d\.]+/].to_f
        price_in_cents   = (price_in_dollars * 100).to_i
      end

      private def skus
        @skus ||= js_variable_value("productSkus")
      end

      private def css_element_value(selector)
        page.css(selector)
            .inner_html
            .gsub("<br>", "\n")
            .gsub("<li>", "- ")
            .yield_self { |x| Nokogiri::HTML.fragment(x) }
            .text
            .tr("\r", "")
            .strip
      end

      private def js_variable_value(variable)
        json = dynamic_page.execute_script("return JSON.stringify(#{variable});")
        JSON.parse(json)
      end

      private def dynamic_page
        @dynamic_page ||= Product::Browser.eval_page(raw_page)
      end
    end
  end
end
