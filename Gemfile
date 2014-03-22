source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# enable features such as static asset serving and logging on Heroku
gem 'rails_12factor', '~> 0.0.2', group: :production

# Makes http fun! Also, makes consuming restful web services dead easy.
gem 'httparty', '~> 0.13.0'

# ZURB Foundation on Sass/Compass
gem 'foundation-rails', '~> 5.2.1.0'

# Injects Angular.js into your asset pipeline as well as other Angular modules.
gem 'angularjs-rails', '~> 1.2.14'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  # RSpec for Rails
  gem 'rspec-rails', '~> 2.14.1'

  # An IRB alternative and runtime developer console
  gem 'pry', '~> 0.9.12.6'
end

group :test do
  # integration testing tool for rack based web applications.
  gem 'capybara', '~> 2.2.1'

  # allows stubbing HTTP requests and setting expectations on HTTP requests
  gem 'webmock', '~> 1.15.2'

  # simple API to record and replay your test suite's HTTP interactions
  gem 'vcr', '~> 2.8.0'

  # tool for writing automated tests of websites
  gem 'selenium-webdriver', '~> 2.40.0'
end

# for Heroku
ruby "2.1.1"