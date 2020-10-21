require 'active_resource/formats/calendar_format'

# For making requests authorized requests in the iCalendar format
class Calendar < KicksiteSvcBearerAuth
  self.include_format_in_path = false
  self.collection_name = '/'

  class << self
    def format
      ActiveResource::Formats::CalendarFormat
    end
  end
end
