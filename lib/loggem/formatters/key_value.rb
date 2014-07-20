module Loggem
  module Formatters
    class KeyValue

      def call(data)
        data.each.map { |k, v| format k, v }.join ' '
      end



      private

      def format(key, value)
        %Q|#{key}="#{format_value value}"|
      end



      def format_value(value)
        case value
          when String
            value.gsub('"') { %q|\"| }
          when Symbol
            value
          else
            value.inspect
        end
      end

    end
  end
end