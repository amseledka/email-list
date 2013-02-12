source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'mysql2'
gem 'jquery-rails'
gem 'haml'
gem 'haml-rails'

gem 'capybara'

gem 'unicorn'
gem 'capistrano-helpers'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'rspec-rails', '~> 2.8.0'
  gem 'thin'
end

group :development do
  # deploying
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'rvm-capistrano'
end