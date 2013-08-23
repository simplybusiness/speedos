Gem::Specification.new do |gem|
  gem.authors       = ['SimplyBusiness']
  gem.email         = ['peter.wu@xbridge.com']
  gem.description   = %q{Incorporates BrowserMob and Capybara(selenium) to run front-end tests and capture performance information}
  gem.summary       = %q{Speedos incorporates BrowserMob Proxy along with Capybara, recording the web traffic and time taken to load all elements on each of the pages within a user journey. The aim is to identify any performance related issues, such as specific items that take a long time to load on page.}
  gem.homepage      = %q{https://github.com/simplybusiness/speedos}

  gem.files         = `git ls-files`.split($\)
  gem.name          = 'speedos'
  gem.require_paths = ['lib']
  gem.version       = "0.0.7"
  gem.executables   = 'speedos'
  gem.license       = 'MIT'

  gem.add_runtime_dependency 'mongoid',              '3.1.4'
  gem.add_runtime_dependency 'rake',                 '10.1.0'
  gem.add_runtime_dependency 'faker',                '1.1.2'
  gem.add_runtime_dependency 'logger',               '1.2.8'
  gem.add_runtime_dependency 'browsermob-proxy',     '0.1.1'
  gem.add_runtime_dependency 'selenium-webdriver',   '2.33'
  gem.add_runtime_dependency 'capybara',             '2.1.0'

  gem.add_development_dependency 'rspec',            '2.14.1'
  gem.add_development_dependency 'database_cleaner', '1.0.1'
end
