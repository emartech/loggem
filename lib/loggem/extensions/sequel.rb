require 'sequel'

module Loggem
  module Extensions
    module Sequel

      def self.included(klass)
        klass.send :remove_method, :log_duration
      end



      def log_duration(duration, message)
        return if message.start_with? 'SET '

        log_each((lwd = log_warn_duration and duration >= lwd) ? :warn : sql_log_level, {message: message, duration: (duration * 1000).round(4), source: 'sequel'})
      end

    end

    ::Sequel::Database.send :include, Sequel
  end
end
