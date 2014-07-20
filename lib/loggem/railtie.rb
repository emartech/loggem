require 'rails/railtie'
#require 'action_view/log_subscriber'
#require 'action_controller/log_subscriber'

module Lograge
  class Railtie < Rails::Railtie
    config.loggem = ActiveSupport::OrderedOptions.new
    config.loggem.enabled = false

    initializer :loggem do |app|
      ::Loggem.setup_rails app if config.loggem.enabled
    end
  end
end