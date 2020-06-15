module ActiveResource
  module Formats
    # defines a CSV Format that can be used with ActiveResource
    module CsvFormat
      module_function

      def extension
        'csv'
      end

      def mime_type
        'text/csv'
      end

      def encode(_hash, _options = nil)
        raise NotImplementedError
      end

      def decode(csv)
        csv
      end
    end
  end
end

module Kicksite
  # Allows for retrieval of CSV formatted data out of the CRUD api
  class Csv9000 < KicksiteSvcBearerAuth
    self.collection_name = ''
    self.element_name = ''

    class << self
      def format
        ActiveResource::Formats::CsvFormat
      end
    end
  end
end
