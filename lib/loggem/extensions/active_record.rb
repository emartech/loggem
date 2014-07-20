require 'active_record'

module Loggem
  module Extensions
    module ActiveRecord

      def self.included(klass)
        klass.send :remove_method, :sql
      end



      def sql(event)
        payload = event.payload
        return if %w(SCHEMA EXPLAIN).include?(payload[:name])

        debug message: payload[:sql], duration: event.duration.round(4), description: payload[:name], source: 'active_record'
      end

    end

    ::ActiveRecord::LogSubscriber.send :include, ActiveRecord
  end
end

