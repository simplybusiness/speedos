# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
ENV['APP_ENV'] = 'test'
require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'speedos' # and any other gems you need

Speedos::Configuration.load_mongoid_config(File.join(File.dirname(__FILE__), 'support', 'mongoid.yml'))


RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  DatabaseCleaner[:mongoid].strategy = :truncation

  config.before :each do
    Mongoid.purge!
    DatabaseCleaner.clean
  end
end
