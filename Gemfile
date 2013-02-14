source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'mysql2'
gem 'jquery-rails'
gem 'haml'
gem 'haml-rails'
gem 'csv_shaper'

gem 'headless'
gem 'capybara'
gem 'rspec-rails', '~> 2.8.0'
gem 'whenever', :require => false

gem 'unicorn'
gem 'capistrano-helpers'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'thin'
end

group :development do
  # deploying
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'rvm-capistrano'
end