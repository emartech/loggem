require 'json'
require 'logger'

module Loggem
  class Logger

    attr_reader :context



    def initialize(logger = ::Logger.new(STDOUT))
      @logger = logger
      @context = {}
      @formatter = ::Loggem::Formatters::Json.new
    end



    def formatter=(formatter)
      raise ArgumentError.new("Formatter must respond to 'call'") unless formatter.respond_to?(:call)

      @formatter = formatter
    end



    [:debug, :info, :warn, :error, :fatal].each do |level|
      define_method level do |message = nil, payload = {}, &block|
        message ||= block.call if block

        raise ArgumentError, 'Neither message nor block was given' if message.nil?

        log level, message, payload
      end
    end



    def method_missing(method, *arguments)
      logger.public_send method, *arguments
    end



    private

    attr_reader :logger, :formatter



    def log(level, message, payload)
      logger.public_send level, formatter.call(build_event(level, message, payload))
    end



    def build_event(level, message, payload)
      ::Loggem::Event.new(level: level,
                          message: message,
                          payload: payload,
                          context: context).data
    end

  end
end
