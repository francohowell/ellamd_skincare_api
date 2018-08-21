class Product
  module Duplicate
    class Resolver
      def self.run
        new.run
      end

      def run
        Product::Duplicate::Enumerator.new.each do |product_batch|
          process_product_batch(product_batch)
        end
      end

      private def process_product_batch(product_batch)
        origin = product_batch.shift

        origin.mark_as_original
        origin.save!

        product_batch.each do |product|
          product.mark_as_duplicate_of(origin)
          product.save!
        end
      end
    end
  end
end
