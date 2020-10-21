module ActiveResource
  module Formats
    # An formatter that allows for plain text with the calendar
    module CalendarFormat
      extend self # rubocop:disable Style/ModuleFunction

      def extension
        ''
      end

      def mime_type
        'application/calendar'
      end

      def encode(text)
        text
      end

      def decode(text)
        text
      end
    end
  end
end
