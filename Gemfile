source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0', '>= 7.0.5'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Sprockets is now an optional dependency
gem 'sprockets-rails', '~> 3.4', '>= 3.4.2'
# Use SCSS for stylesheets
gem 'sassc-rails', '~> 2.1', '>= 2.1.2'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.4', '>= 5.4.4'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Nokogiri gem
gem 'nokogiri', '~> 1.10', '>= 1.10.10'
# Watir gem
gem 'watir', '~> 6.16', '>= 6.16.5'
# Whenever gem
gem 'whenever', '~> 0.9.4', require: false
# PG Search
gem 'pg_search', '~> 2.3', '>= 2.3.5'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Act-as-taggable-on gem
# gem 'acts-as-taggable-on', '~> 6.0'

#Act-as-votable gem

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Devise gem
gem 'devise', '~> 4.7', '>= 4.7.3'

# Pundit gem
gem 'pundit', '~> 2.1'

# Act as taggable
gem 'acts-as-taggable-on', '~> 9.0', '>= 9.0.1'

# Cloudinary gem
gem 'cloudinary', '~> 1.18', '>= 1.18.1'

# Rails Admin gem
gem 'rails_admin', '~> 3.1', '>= 3.1.2'

# Faker gem
gem 'faker', '~> 2.14'

gem 'dotenv-rails', groups: [:development, :test]
gem 'autoprefixer-rails', '~> 10.0', '>= 10.0.2.0'
gem 'font-awesome-sass'
gem 'simple_form'

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rspec-html-matchers'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.33'
  gem 'selenium-webdriver', '~> 3.142', '>= 3.142.7'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdriver', '~> 0.17.0'
  gem 'launchy', '~> 2.5'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Geocoder gemfile
gem 'geocoder'
gem 'turbolinks_render'

# HTTP client api for Ruby.
gem "net-http"