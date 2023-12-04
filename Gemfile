# frozen_string_literal: true

source 'https://rubygems.org'
ruby '3.2.2'

# Rails
#-------------------------------------------------------------------------------
gem 'puma', '~> 4.1'
gem 'rails', '~> 7.0', '>= 7.0.5'

# Database
#-------------------------------------------------------------------------------
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search', '~> 2.3', '>= 2.3.5'

# Redis
#-------------------------------------------------------------------------------
gem 'redis', '~> 4.0' # Use Redis adapter to run Action Cable in production

# Views
#-------------------------------------------------------------------------------
gem 'simple_form'

# Asset Pipeline
#-------------------------------------------------------------------------------
gem 'sassc-rails', '~> 2.1', '>= 2.1.2' # Use SCSS for stylesheets
gem 'sprockets-rails', '~> 3.4', '>= 3.4.2' # Sprockets is now an optional dependency
gem 'webpacker', '~> 5.4', '>= 5.4.4' # Transpile app-like JavaScript
gem 'turbolinks', '~> 5' # Turbolinks makes navigating your web application faster
gem 'turbolinks_render'
gem 'autoprefixer-rails', '~> 10.0', '>= 10.0.2.0' # Parse CSS and add vendor prefixes to CSS rules
gem 'font-awesome-sass' # Sass-powered version of Font Awesome for Ruby projects with specific support for Ruby on Rails and Sprockets

# Authentication & Authorisation
#-------------------------------------------------------------------------------
gem 'devise', '~> 4.7', '>= 4.7.3'
gem 'pundit', '~> 2.1'

# Monitoring/Alerting/Comparing
#-------------------------------------------------------------------------------
gem 'rails_admin', '~> 3.1', '>= 3.1.2'

# Background processing
#-------------------------------------------------------------------------------
gem 'whenever', '~> 0.9.4', require: false

# API
#-------------------------------------------------------------------------------
gem 'jbuilder', '~> 2.7' # Build JSON APIs with ease.

# Geocoding
#-------------------------------------------------------------------------------
gem 'geocoder'

# Scrapping
#-------------------------------------------------------------------------------
gem 'nokogiri', '~> 1.10', '>= 1.10.10'
gem 'watir', '~> 6.16', '>= 6.16.5'

# Profiling
#-------------------------------------------------------------------------------
gem 'rack-mini-profiler'
gem 'memory_profiler' # For memory profiling
gem 'stackprof' # For call-stack profiling flamegraphs
gem 'flamegraph'

# External Services
#-------------------------------------------------------------------------------
gem 'cloudinary', '~> 1.18', '>= 1.18.1'

# Miscellaneous gems
#-------------------------------------------------------------------------------
gem 'faker', require: false
gem 'acts-as-taggable-on', '~> 9.0', '>= 9.0.1'
gem 'pry-rails'


group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'bootsnap', '>= 1.4.2', require: false # Reduces boot times through caching; required in config/boot.rb
end

group :development do
  gem 'web-console', '>= 3.3.0' # Access an interactive console on exception pages or by calling 'console' anywhere in the code
end

group :test do
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rspec-html-matchers'
end

# Profile CPU & memory
group :profile do
  gem 'ruby-prof'
end
