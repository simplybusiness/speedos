module Speedos
  class Log
    def self.logger
      @logger ||= Logger.new(File.join(File.dirname(__FILE__), "..", "log", "performance.log"))
    end

    def self.logger= logger
      @logger = logger
    end

    def self.method_missing meth, *args, &block
      logger.send(meth, *args)
    end
  end
end
