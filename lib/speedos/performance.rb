module Speedos
  class Performance
    def self.test
      Log.info("Test begins")
      page = Page.new
      page.new_har

      yield page if block_given?

      Log.info("Test Complete")
      success = true
    rescue Exception => e
      Log.error("#{e}")
      Log.error("#{e.backtrace}")
      success = false
    ensure
      Record.create(JSON.load(page.get_har.to_json).merge(success: success))
      page.server_proxy.close
      page.server.stop
    end
  end
end
