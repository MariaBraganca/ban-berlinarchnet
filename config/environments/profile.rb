# File: config/environments/profile.rb

Rails.application.configure do
  # Inherit from the development config
  # config = Rails.application.config_for(:development).symbolize_keys
  # config.each do |key, value|
  #   send("#{key}=", value)
  # end

  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = false

  # Eager load code on boot. This is necessary in production, but can
  # cause slowdowns in development and profile environments.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Enable caching for profiling to simulate production-like scenarios.
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future Expires headers.
  # This is not needed in profiling and can be disabled.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Specifies the header that your server uses for sending files.
  config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Set to :debug to see everything in the log.
  config.log_level = :debug

  # Customize any additional options below...

end
