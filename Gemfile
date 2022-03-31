source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rake', '12.3.0'
gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18.2'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# gem 'therubyracer', platforms: :ruby
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# gem 'bcrypt', '~> 3.1.7'
gem 'capistrano',         require: false
gem 'capistrano-rbenv',     require: false
gem 'capistrano-rails',   require: false
gem 'capistrano-bundler', require: false
gem 'capistrano-passenger',   require: false
gem 'capistrano-rails-console'
gem "capistrano-resque", "~> 0.2.2", require: false
gem 'capistrano-faster-assets', '~> 1.0'


group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano-rake', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap', '~> 4.0.0.beta2.1'
gem 'jquery-rails'
gem 'simple_form'
gem 'devise'
gem 'faker'
gem 'webpacker'
gem 'react-rails'
gem 'country_select'
gem 'select2-rails'
gem 'kaminari'
gem 'bootstrap4-kaminari-views'
gem 'redis', '3.0.4'
gem 'redis-namespace'
gem "pdfkit"
gem 'unicorn'
gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"
gem 'wkhtmltopdf-binary'
gem 'resque'
gem 'resque-scheduler'
gem 'resque-pool'
gem 'ransack'
gem "therubyracer"
gem "execjs"
gem 'foreman'
