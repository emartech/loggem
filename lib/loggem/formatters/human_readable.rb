module Loggem
  module Formatters
    class HumanReadable

      def call(data)
        data.reduce("") { |memo, (key, value)| memo += "\n\t#{key}: #{value}" }
      end

    end
  end
end
