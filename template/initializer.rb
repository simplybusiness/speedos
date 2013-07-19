require 'bundler'
Bundler.require

require 'speedos'
Speedos::Configuration.load_mongoid_config(File.join(File.dirname(__FILE__), '..', 'config', 'mongoid.yml'))
Speedos::Log.logger = File.join(File.dirname(__FILE__), "..", "log", "performance.log")

DIR = ['helpers']

DIR.each { |dir| $:.unshift File.join(File.dirname(__FILE__), '..', dir) }
DIR.each { |dir| Dir["#{File.join(File.dirname(__FILE__), '..', dir)}/*.rb"].each {|file| require file }}

