require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BanBerlinarchnet
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Add the ruby prof rack adapter to the middleware stack.
    # The path is where profiling results will be stored.
    # By default the rack adapter will generate a html call graph report and flat text report.
    if Rails.env.profile?
      config.middleware.use Rack::RubyProf, :path => './tmp/profile'
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
