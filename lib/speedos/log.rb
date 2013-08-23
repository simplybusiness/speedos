module Speedos
  class Log
    def self.logger
      @logger ||= Logger.new(STDOUT)

      @logger.formatter = proc { |severity, datetime, progname, msg| "[#{severity}] #{datetime}: #{msg}\n" }
      @logger
    end

    def self.logger= logger
      logger = Logger.new(logger) if logger.is_a? String
      @logger = logger
    end

    def self.method_missing meth, *args, &block
      logger.send(meth, *args)
    end
  end
end
