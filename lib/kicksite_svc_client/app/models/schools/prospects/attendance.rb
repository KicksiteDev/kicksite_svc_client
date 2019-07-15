require_relative '../../../helpers/kicksite_svc_bearer_auth'
require_relative '../../../helpers/paginated_collection'

module Schools
  module Prospects
    # REST resources specific to Attendances associated with given prospect
    class Attendance < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/prospects/:prospect_id/'
      self.collection_parser = PaginatedCollection

      ATTENDANCE_DATETIME_KEYS = %w[
        checkin
      ].freeze

      def initialize(attributes = {}, persisted = false)
        ATTENDANCE_DATETIME_KEYS.each do |key|
          attributes[key] = to_datetime(attributes[key])
        end

        super(attributes, persisted)
      end
    end
  end
end
