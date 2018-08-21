module TransactionScripts
  module Regimen
    class Update
      attr_reader :regimen, :regimen_params

      def initialize(regimen:, regimen_params:)
        @regimen = regimen
        @regimen_params = regimen_params
      end

      def run
        result = nil

        ApplicationRecord.transaction do
          regimen.regimen_products.delete_all

          regimen_product_hashes.each do |regimen_product_hash|
            product_hash = regimen_product_hash[:product]
            product = hash_to_product(product_hash)

            regimen.regimen_products.build(
              period: regimen_product_hash[:period],
              position: regimen_product_hash[:position],
              product: product
            )
          end

          result = regimen.save
        end

        result
      end

      private def hash_to_product(product_hash)
        if product_hash[:id]
          Product.find_by(id: product_hash[:id])
        else
          Product.create!(store: "custom", name: product_hash[:name], is_pending: true)
        end
      end

      private def regimen_product_hashes
        regimen_params[:regimen_products]
      end
    end
  end
end
