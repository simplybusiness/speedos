Gem::Specification.new do |gem|
  gem.authors       = ['SimplyBusiness']
  gem.email         = ['peter.wu@xbridge.com']
  gem.description   = %q{performance testing framework}
  gem.summary       = %q{performance testing framework}
  gem.homepage      = %q{https://github.com/simplybusiness/speedos}

  gem.files         = `git ls-files`.split($\)
  gem.name          = 'speedos'
  gem.require_paths = ['lib', 'models']
  gem.version       = "0.0.1"

  gem.add_runtime_dependency 'mongoid',              '3.1.4'
  gem.add_runtime_dependency 'faker',                '1.1.2'
  gem.add_runtime_dependency 'logger',               '1.2.8'
  gem.add_runtime_dependency 'browsermob-proxy',     '0.1.1'
  gem.add_runtime_dependency 'selenium-webdriver',   '2.33'
  gem.add_runtime_dependency 'capybara',             '2.1.0'

  gem.add_development_dependency 'rspec',            '2.14.1'
  gem.add_development_dependency 'database_cleaner', '1.0.1'
end
