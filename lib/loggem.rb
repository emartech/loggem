require 'loggem/version'
require 'loggem/logger'
require 'loggem/event'

require 'loggem/formatters/raw'
require 'loggem/formatters/json'
require 'loggem/formatters/key_value'
require 'loggem/formatters/human_readable'


module Loggem

  def self.setup_rails(app)
    config = app.config.loggem

    logger = Loggem::Logger.new config.logger
    logger.formatter = config.formatter || ::Loggem::Formatters::Json.new
    logger.context.merge!(config.context || {})
    (config.extensions || []).each { |ext| load_extension ext }

    app.config.logger = logger
    ::Rails.logger = logger
    ::ActionController::Base.logger = logger
  end


  def self.load_extension(extension)
    require "loggem/extensions/#{extension}"
  end

end

require 'loggem/railtie' if defined?(Rails)