require_relative '../../../helpers/kicksite_svc_bearer_auth'
require_relative '../../../helpers/paginated_collection'

module Schools
  module Prospects
    # REST resources specific to Appointments associated with given prospect
    class Appointment < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/prospects/:prospect_id/'
      self.collection_parser = PaginatedCollection

      APPOINTMENT_DATETIME_KEYS = %w[
        start_at
        end_at
      ].freeze

      PAST_FILTER = 'past'.freeze
      FUTURE_FILTER = 'future'.freeze

      START_AT_SORT_BY = 'start_at'.freeze

      def initialize(attributes = {}, persisted = false)
        APPOINTMENT_DATETIME_KEYS.each do |key|
          attributes[key] = to_datetime(attributes[key])
        end

        super(attributes, persisted)
      end
    end
  end
end