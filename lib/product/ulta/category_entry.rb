class Product
  module Ulta
    class CategoryEntry
      attr_reader :id, :name, :url

      def initialize(name:, url:)
        self.name = name
        self.url  = url
      end

      private def name=(name)
        @name = name
      end

      private def url=(url)
        @id  = url[/(?<=\?N\=)\w+$/]
        @url = if url.starts_with?("//")
                 "https:#{url}"
               else
                 url
               end
      end
    end
  end
end
