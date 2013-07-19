module Speedos
  class Page
    def server
      if !@server
        @server = BrowserMob::Proxy::Server.new(File.join(File.dirname(__FILE__), "..", "bin", "browsermob-proxy-2.0-beta-8", "bin", "browsermob-proxy"))
        @server.start
      end
      @server
    end

    def server_proxy
      if !@proxy
        @proxy = server.create_proxy
      end
      @proxy
    end

    def get_har
      server_proxy.har
    end

    def new_har
      server_proxy.new_har "", capture_headers: true
    end

    def firefox_profile
      profile       = Selenium::WebDriver::Firefox::Profile.new
      profile.proxy = server_proxy.selenium_proxy
      profile["network.proxy.ssl"]      = server_proxy.host
      profile["network.proxy.ssl_port"] = server_proxy.port
      profile
    end

    def driver
      @driver ||= reset_driver
    end

    def reset_driver
      Capybara.register_driver :selenium do |app|
        Capybara::Selenium::Driver.new(app, :profile => firefox_profile)
      end
      Capybara.default_driver = :selenium
      @driver = Capybara::Session.new(:selenium)
    end

    def is value
      raise "Page name cannot be empty" if value.empty?
      server_proxy.new_page value
      yield
    end
  end
end
