require_relative '../../../helpers/kicksite_svc_bearer_auth'
require_relative '../../../helpers/paginated_collection'

module Schools
  module Students
    # REST resources specific to Automations associated with given Student
    class Automation < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/students/:student_id/'
      self.collection_parser = PaginatedCollection

      PAST_FILTER = 'past'.freeze
      FUTURE_FILTER = 'future'.freeze

      START_AT_SORT_BY = 'start_at'.freeze

      def initialize(attributes = {}, persisted = false)
        super(attributes, persisted)
      end
    end
  end
end
