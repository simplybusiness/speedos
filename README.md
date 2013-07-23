# Speedos

## What is Speedos?
Speedos incorporates [BrowserMob Proxy](http://bmp.lightbody.net) along with [Capybara](https://github.com/jnicklas/capybara), recording the web traffic and time taken to load all elements on each of the pages within a user journey. The aim is to identify any performance related issues, such as specific items that take a long time to load on page.

## Installation
Put speedos on your Gemfile

	gem 'speedos'

Or, install it via rubygem

	$ gem install speedos

The easiest and quickest way to get you started is to run the init script

	$ speedos init

and it will generate following file structure for you:

	├── .irbrc
	├── Rakefile
	├── config
	│   ├── initializer.rb
	│   └── mongoid.yml
	├── helpers
	├── log
	└── scripts

## Configuration

### Mongoid
It is essential to let speedos know the location of your mongoid.yml by...

	Speedos::Configuration.load_mongoid_config('/location/to/my/mongoid.yml')

Refer to mongoid documentation for the correct format of mongoid.yml <http://mongoid.org/en/mongoid/docs/installation.html>

### Logger
By default, speedos will output all the logging using STDOUT, you can override this method by either

	# pass in a Logger Object
	Speedos::Log.logger = Logger.new(…)

or

	# the location where you want the log to be saved
	Speedos::Log.logger = "/location/to/desire/log/location"

## Create your own script
you should put all your script under `/scripts`

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

## To execute the scripts
If you use `init` to generate your structure, you should get `Rakefile` created. And it will create rake task for all the scripts you have created in `/scripts`

	└── scripts
	    ├── earth
	    │   └── grass.rb
	    ├── human.rb
	    └── sky
	        ├── cloud.rb
	        └── rain.rb

For example, if you have above scripts structure, then you should get the following rake tasks created

	$ rake -T

	rake earth:grass  # run the script located in /Users/pwu/test/scripts/earth/grass.rb
	rake human        # run the script located in /Users/pwu/test/scripts/human.rb
	rake sky:cloud    # run the script located in /Users/pwu/test/scripts/sky/cloud.rb
	rake sky:rain     # run the script located in /Users/pwu/test/scripts/sky/rain.rb


## Report
You can access the performance data via `Speedos::Record` object

	$ irb

	> Speedos::Record.first.pages
	#=> [Entries: ["simplybusiness-main-page"], Entries: ["google-result-page"]]

	> Speedos::Record.first.pages.first
	#=> Entries: ["simplybusiness-main-page"]

	> Speedos::Record.first.pages.first.total_load_time
	#=> 3828.0
	# which is the total loading time for the page in milliseconds



