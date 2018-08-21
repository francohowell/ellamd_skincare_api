# TODO: implement connection pool to support multithreaded crawler
class Product
  class Browser
    attr_reader :driver

    def self.eval_page(raw_page)
      browser = new
      browser.driver.get("data:text/html;charset=utf-8," + raw_page)
      browser.driver
    end

    def initialize
      randomize_driver
    end

    def navigate_to(url)
      driver.navigate.to(url)
    end

    def page_source
      driver.page_source
    end

    private def randomize_driver
      @driver.quit if @driver.present?
      @driver = Selenium::WebDriver.for(:chrome, options: driver_options)
    end

    private def driver_options
      options = Selenium::WebDriver::Chrome::Options.new(binary: path_to_chrome_binary)
      options.add_argument("--headless")
      # options.add_argument("user-agent=#{random_user_agent}")
      # options.add_argument("window-size=#{random_window_size}")
      # options.add_argument("user-data-dir=#{path_to_user_profile}")

      # Dir.glob("#{Rails.root}/data/ParanoidBrowser extensions/*.crx") do |extension|
      #   options.add_extension(extension)
      # end

      options
    end

    private def random_user_agent
      [
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36",
        "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
        "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36",
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36"
      ].sample
    end

    private def random_window_size
      [
        "1366,768",
        "1920,1080",
        "1440,900",
        "1280,1024",
        "1600,900",
        "1536,864",
        "1280,1024",
        "1280,720",
        "1024,768"
      ].sample
    end

    private def path_to_user_profile
      "/home/vasily/.config/google-chrome/Profile 1"
    end

    private def path_to_chrome_binary
      ENV.fetch("GOOGLE_CHROME_SHIM", "/usr/bin/google-chrome")
    end
  end
end
