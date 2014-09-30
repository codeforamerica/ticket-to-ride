source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

# Use SCSS for stylesheets
gem 'sass-rails', '4.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '2.5.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '4.0.1'

# Use jquery as the JavaScript library
gem 'jquery-rails', '3.1.0'

# Moment JS (needed for X-Editable combodate fields)
gem 'momentjs-rails', '2.6.0'

# select2 JS library (needed for X-Editable select2 fields)
gem 'select2-rails', '3.5.7'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.0.7'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '0.4.0',          group: :doc

gem 'birthday', '0.3.1'

gem 'knockoutjs-rails', '3.1.0.1'

gem 'anjlab-bootstrap-rails', '3.0.0.3', :require => 'bootstrap-rails'

gem 'high_voltage', '2.1.0'

# Wicked: Used for created wizard-like form progression
gem 'wicked', '1.0.3'

# Added for Windows timezone support
gem 'tzinfo-data', '1.2014.5'

# Used for Bootstrap Slider
gem 'bootstrap-slider-rails', '1.9.0'

# Validations for dates
gem 'validates_timeliness', '3.0.14'

# For validating e-mail formats
gem 'validates_email_format_of'

# Template engine for Admin screens (per Andrew's recommendation)
gem 'slim-rails', '2.1.5'

# For attaching supplemental materials
gem 'paperclip'

# DEVELOPMENT ONLY
group :development do

  # testing
    # includes RSpec in a wrapper to make it play nicely with Rails
  gem 'rspec-rails'
    # replaces Rails' default fixtures for feeding test data to the test suite with more preferable factories
  gem 'factory_girl_rails', "~> 4.0"

  # JRuby install items
  platform :jruby do
    # Use jdbcsqlite3 as the database for Active Record when running JRuby
    gem 'activerecord-jdbcsqlite3-adapter', '1.3.9'

    # Install Open SSL to provide a security impelementation
    gem 'jruby-openssl', '0.9.5'
  end

  # MRI Ruby or Windows Ruby
  platform :mri, :mingw do
    # Use sqlite3 as the development database when running C Ruby
    gem 'sqlite3', '1.3.9'  
  end

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '1.1.3'
end

# PRODUCTION ONLY
group :production do
  # For Heroku static asset serving and logging
  gem 'rails_12factor', '0.0.2'

  # Production grade web server
  gem 'unicorn', '4.8.3'

  # Use Postgresql as the deployment database (staging and production)
  gem 'pg', '0.17.1'
end

# TESTING ONLY
group :test do
    # generates names, email addresses, and other placeholders for factories
  gem 'faker'
    # makes it easy to programmatically simulate the users' interactions
  gem 'capybara'
    #watches the app and tests and runs specs automatically when it detects changes
  gem 'guard'
  gem 'guard-rspec'
    # opens the default web browser upon failed integration specs to show what the application is rendering
  gem 'launchy'
end

ruby '1.9.3'

