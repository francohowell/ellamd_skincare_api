# TODO: come up with a more efficient implementation
#   - don't load ids of all products with duplicates into memory
#   - don't process set of products twice(== all products in the set except one have :origin_id set)
#   - don't make DB reorder products twice
#   - there's no need to order products by store and number of reviews during the first run
class Product
  module Duplicate
    class Enumerator
      include Enumerable

      PAGE_SIZE = 50
      ORDER_BY = "brand ASC, name ASC, store ASC, number_of_reviews DESC NULLS LAST"

      def each
        duplicates_set = []

        ordered_product_ids.each_slice(PAGE_SIZE) do |product_ids|
          Product.where(id: product_ids).order(ORDER_BY).each do |product|
            original_product = duplicates_set[0]

            if original_product.nil? || product.is_duplicate_of?(original_product)
              duplicates_set << product
            else
              yield duplicates_set
              duplicates_set = [product]
            end
          end
        end

        yield duplicates_set
      end

      # `ordered_product_ids' loads ids of all duplicated Products into memory
      #    yet it should not be a problem at current scale(5000-50000 Products)
      private def ordered_product_ids
        ordered_products.pluck(:id)
      end

      private def ordered_products
        products = Product.order(ORDER_BY).where <<~SQL
          EXISTS (SELECT 1
                  FROM products AS products2
                  WHERE products.id   != products2.id
                    AND products.brand = products2.brand
                    AND products.name  = products2.name
                  )
        SQL
      end
    end
  end
end
