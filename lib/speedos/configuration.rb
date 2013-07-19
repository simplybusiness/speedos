module Speedos
  module Configuration
    def self.app_env
      ENV['APP_ENV'] || 'development'
    end

    def self.load_mongoid_config path
      Mongoid.load!(path, app_env.to_sym)
    end
  end
end
