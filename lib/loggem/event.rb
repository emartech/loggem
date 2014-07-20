module Loggem
  class Event

    def initialize(arguments = {})
      @data = {}
      @arguments = arguments
    end



    def data
      parse_arguments @arguments
    end



    private

    STACKTRACE_SIZE = 5



    def parse_arguments(arguments)
      @data.merge! at: arguments.fetch(:level)
      @data.merge! parse arguments.fetch(:message)
      @data.merge! parse arguments.fetch(:payload, {})
      @data.merge! arguments.fetch(:context, {})
    end



    def parse(object)
      case object
        when Exception
          return {message: object.message} if object.backtrace.nil?

          {message: object.message, stacktrace: object.backtrace[0..(STACKTRACE_SIZE - 1)].join("\n")}

        when Hash
          object

        else
          {message: object.to_s.strip}

      end
    end

  end
end