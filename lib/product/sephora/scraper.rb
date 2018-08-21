# TODO: remove redundant whitespace in description, diagnoses and instructions fields
class Product
  module Sephora
    class Scraper
      attr_reader :page, :product_entry

      SEPHORA_URL_PREFIX = "https://www.sephora.com"

      def initialize(page:, url: nil)
        @page              = page
        @product_entry     = JSON.parse(page)
        @json_parser_error = false

      rescue JSON::ParserError
        @json_parser_error = true
      end

      def valid?
        !@json_parser_error && product_entry["errors"].blank? && name.present?
      end

      def product_attributes
        {
          store: store,
          store_id: store_id,
          brand: brand,
          name: name,
          product_url: product_url,
          image_url: image_url,
          description: description,
          diagnoses: diagnoses,
          instructions: instructions,
          tags: tags,
          packages: packages,
          average_rating: average_rating,
          number_of_reviews: number_of_reviews,
          raw: raw
        }
      end

      def product_ingredients
        raw_ingredients = current_sku["ingredientDesc"]

        if raw_ingredients.blank?
          Rails.logger.warn "[Sephora][#{store_id}] Ingredients have not been found"
          return []
        end

        raw_ingredients.rpartition("<br>")[2]
                       .split(",")
                       .map { |ingredient| ingredient.gsub(/\.\z/, "").strip }
      end

      #------------------------------------------------------------------------
      # Product properties
      private def store
        "sephora"
      end

      private def store_id
        product_entry["productId"] or raise("[Sephora] Store ID has not been found")
      end

      private def brand
        product_entry.dig("brand", "displayName")&.titleize or raise("Brand has not been found")
      end

      private def name
        product_entry["displayName"]
      end

      private def product_url
        url_suffix = product_entry["targetUrl"] or raise("Product URL has not been found")
        "#{SEPHORA_URL_PREFIX}#{url_suffix}"
      end

      private def image_url
        image_entries = current_sku["skuImages"]
        raise "Image URL has not been found" if image_entries.blank?

        best_resolution = image_entries.keys
                                       .map { |key| {key: key, resolution: key[/\d+/].to_i} }
                                       .sort_by { |kr| kr[:resolution] }
                                       .last[:key]
        best_resolution_image_url_suffix = image_entries[best_resolution]

        "#{SEPHORA_URL_PREFIX}#{best_resolution_image_url_suffix}"
      end

      private def description
        rich_text_field(
          key: "longDescription",
          part_before: "<b>If you want to know more…</b>",
          part_after: "<b>"
        )
      end

      private def diagnoses
        rich_text_field(
          key: "longDescription",
          part_before: "<b>Solutions for:</b>",
          part_after: "<b>"
        )
      end

      private def instructions
        rich_text_field(
          key: "suggestedUsage",
          part_before: "<b>Suggested Usage:</b>",
          part_after: "<b>"
        )
      end

      private def tags
        # Last tag is always "Skincare", remove it
        tags_rec([], product_entry["parentCategory"]).slice(0..-2).reverse
      end

      private def packages
        all_skus.map do |package|
          unformatted_price = package["listPrice"] or raise("Price has not been found")
          price_in_dollars = unformatted_price[/[\d\.]+/] or raise("Price has not been extracted")
          price_in_cents = (price_in_dollars.to_f * 100).to_i

          {
            "sku" => package["skuId"],
            "price" => price_in_cents,
            "volume" => package["variationValue"]
          }
        end
      end

      private def average_rating
        result = product_entry["rating"]

        if result.nil?
          Rails.logger.warn("[Sephora][#{store_id}] Average rating has not been found")
        end

        result
      end

      private def number_of_reviews
        result = product_entry["reviews"]

        if result.nil?
          Rails.logger.warn("Sephora][#{store_id}] Number of reviews has not been found")
        end

        result
      end

      private def raw
        product_entry
      end

      #------------------------------------------------------------------------
      # Helper methods
      private def current_sku
        @current_sku ||= product_entry["currentSku"] or raise("Current SKU has not been found")
      end

      private def all_skus
        @all_skus ||= [current_sku] + product_entry["regularChildSkus"].to_a
      end

      private def tags_rec(results, root)
        if root.present?
          tags_rec(results + [root["displayName"]], root["parentCategory"])
        else
          results
        end
      end

      private def rich_text_field(key:, part_before:, part_after:)
        result = product_entry[key]

        if result.blank?
          Rails.logger.warn %Q|[Sephora][#{store_id}] Key "#{key}" has not been found|
          return ""
        end

        result.tr("\r", "")
              .partition(part_before)[2]
              .partition(part_after)[0]
              .yield_self { |fragment| Nokogiri::HTML::DocumentFragment.parse(fragment) }
              .text
              .to_s
              .strip
      end
    end
  end
end
