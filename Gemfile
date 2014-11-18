source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Moment JS (needed for X-Editable combodate fields)
gem 'momentjs-rails'

# select2 JS library (needed for X-Editable select2 fields)
gem 'select2-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc',          group: :doc

gem 'birthday'

gem 'knockoutjs-rails'

gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails'

gem 'high_voltage'

# Wicked: Used for created wizard-like form progression
gem 'wicked'

# Added for Windows timezone support
gem 'tzinfo-data'

# Used for Bootstrap Slider
gem 'bootstrap-slider-rails'

# Validations for dates
gem 'jc-validates_timeliness'

# For validating e-mail formats
gem 'validates_email_format_of'

# Template engine for Admin screens (per Andrew's recommendation)
gem 'slim-rails'

# For attaching supplemental materials
gem 'paperclip'

# For authentication
gem 'devise'

# DEVELOPMENT ONLY
group :development do

  # testing
    # includes RSpec in a wrapper to make it play nicely with Rails
  gem 'rspec-rails'

  # replaces Rails' default fixtures for feeding test data to the test suite with more preferable factories
  gem 'factory_girl_rails'

  # For receiving e-mails during development (password reset, etc)
  gem 'letter_opener'

  # JRuby install items
  platform :jruby do
    # Use jdbcsqlite3 as the database for Active Record when running JRuby
    gem 'activerecord-jdbcsqlite3-adapter'

    # Install Open SSL to provide a security impelementation
    gem 'jruby-openssl'
  end

  # MRI Ruby or Windows Ruby
  platform :mri, :mingw, :x64_mingw do
    # Use sqlite3 as the development database when running C Ruby
    gem 'sqlite3'
  end

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# PRODUCTION ONLY
group :production do
  # For Heroku static asset serving and logging
  gem 'rails_12factor'

  # Production grade web server
  gem 'unicorn'

  # Use Postgresql as the deployment database (staging and production)
  gem 'pg'
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
