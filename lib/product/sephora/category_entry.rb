class Product
  module Sephora
    class CategoryEntry
      attr_reader :id, :name, :url

      def initialize(id:, name: nil, url: nil)
        @id   = id
        @name = name
        @url  = url
      end
    end
  end
end
