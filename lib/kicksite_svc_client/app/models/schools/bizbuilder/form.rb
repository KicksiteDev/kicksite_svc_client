module Schools
  module Bizbuilder
    class Form < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/bizbuilder/'
      self.collection_parser = PaginatedCollection

      ARCHIVED_FILTER = 'archived'.freeze
      ACTIVE_FILTER = 'active'.freeze

      def submit(payload)
        post(:submissions, payload: payload)
      end

      def submissions
        get(:submissions)
      end
    end
  end
end
