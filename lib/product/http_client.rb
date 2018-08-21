class Product
  class HttpClient
    def self.http_client
      HTTP.headers(
        "User-Agent" => "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)",
        "From" => "googlebot(at)googlebot.com"
      )
    end
  end
end
