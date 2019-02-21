require_relative '../../helpers/kicksite_svc_bearer_auth'
require_relative '../../helpers/paginated_collection'

module Schools
  # REST resources specific to Students at a given school
  class Student < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    STUDENT_DATETIME_KEYS = %w[
      inactivated_on
      converted_to_student_on
    ].freeze

    NEW_FILTER = 'new'.freeze
    ACTIVE_FILTER = 'active'.freeze
    LOST_FILTER = 'lost'.freeze
    FROZEN_FILTER = 'frozen'.freeze
    ABSENT_FILTER = 'absent'.freeze

    def initialize(attributes = {}, persisted = false)
      STUDENT_DATETIME_KEYS.each do |key|
        attributes[key] = to_datetime(attributes[key])
      end

      super(attributes, persisted)
    end

    # School student is associated with.
    #
    # @return [School] School student is associated with
    def school
      School.find(prefix_options[:school_id])
    end
  end
end
