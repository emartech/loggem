require 'loggem/version'
require 'loggem/logger'
require 'loggem/event'

require 'loggem/formatters/raw'
require 'loggem/formatters/json'
require 'loggem/formatters/key_value'


module Loggem

  def self.setup_rails(app)
    config = app.config.loggem

    logger = Loggem::Logger.new config.logger
    logger.formatter = config.fetch :formatter, ::Loggem::Formatters::Json.new
    logger.context.merge! config.fetch(:context,  {})
    config.fetch(:extensions, []).each { |ext| load_extension ext }

    ::Rails.logger = app.config.logger = logger
  end


  def self.load_extension(extension)
    require "loggem/extensions/#{extension}"
  end

end

require 'loggem/railtie' if defined?(Rails)