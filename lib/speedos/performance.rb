module Speedos
  class Performance
    def self.test(name="")
      Log.info("#{name} Test begins")
      page = Page.new
      page.new_har

      yield page if block_given?

      Log.info("#{name} Test Complete")
      success = true
    rescue Exception => e
      Log.error("#{e}")
      Log.error("#{e.backtrace}")
      success = false
    ensure
      finialise_record(JSON.load(page.get_har.to_json)['log'], success)
      page.server_proxy.close
      page.server.stop
    end

    def finialise_record(log, success)
      record = Record.create(log: log, success: success)
      record.refresh_information
    end
  end
end
