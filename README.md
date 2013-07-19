# Speeods

## Installation
Put speedos on your Gemfile

	gem 'speedos'

Or, install it via rubygem

	gem install speedos
	

## Configuration

### Mongoid
It is essential to let speeods know where the location of  your mongoid.yml by running this

	Speedos::Configuration.load_mongoid_config('/location/to/my/mongoid.yml')
	
Refer to mongoid documentation for the correct format of mongoid.yml <http://mongoid.org/en/mongoid/docs/installation.html>

### Logger
By default, speedos will output all the logging using STDOUT, you can override this method by either

	# pass in a Logger Object
	Speedos::Log.logger = Logger.new(…)

or

	# pass in the location where you want the log file to be saved
	Speedos::Log.logger = "/location/to/desire/log/location"

## Create your own script
	require 'speedos'
	
	Speedos::Performance.test do |page|
	  page.is 'simplybusiness-main-page' do
	    # page.driver is a capybara session instance
	    page.driver.visit   'https://www.simplybusiness.co.uk/'
	    page.driver.fill_in 'ctaText', with: "IT contractor"
	  end
	
	  page.is 'business-insurance-page' do
	    page.driver.find_button('ctaBtn').click
	  end
	end
  
## Report
You can access the performance data via `Record` object

	Speedos::Record.first.pages
	#=> [Entries: ["simplybusiness-main-page"], Entries: ["google-result-page"]]
	
	Speedos::Record.first.pages.first
	#=> Entries: ["simplybusiness-main-page"]
	
	Speedos::Record.first.pages.first.total_load_time
	#=> 3828.0 
	# which is the total loading time for the page in milliseconds
	
	
	
