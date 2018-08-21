class Product
  class Crawler
    attr_reader :store

    def self.crawl_all_stores
      Rails.logger.info "[ProductCrawler] start"
      Product::Stores.each do |store|
        crawl_store(store)
      end
      Rails.logger.info "[ProductCrawler] finish"
    end

    def self.crawl_store(store)
      new(store).run
    end

    def initialize(store)
      Thread.current[:failed_products_count] = 0
      @store = store
    end

    def run
      Rails.logger.info %Q|[ProductCrawler] crawling store "#{store.name}"|

      store.product_enumerator.new.each do |product_entry|
        next unless product_entry.eligible_for_update?

        if product_entry.valid?
          product_entry.update!
        else
          Thread.current[:failed_products_count] += 1
        end
      end

      Rails.logger.info %Q|[ProductCrawler] finished crawling store "#{store.name}"|
      Rails.logger.info %Q|[ProductCrawler] Number of products not scraped: #{Thread.current[:failed_products_count]}|

      Rails.logger.info %Q|[ProductCrawler] rebuiling search index...|
      # TODO: don't rebuild the whole index after each store
      Product::SearchIndex.rebuild
      Rails.logger.info %Q|[ProductCrawler] finished rebuiling search index|
    end
  end
end
