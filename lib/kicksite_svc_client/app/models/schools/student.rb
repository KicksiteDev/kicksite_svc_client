require_relative '../../helpers/kicksite_svc_bearer_auth'
require_relative '../../helpers/paginated_collection'

module Schools
  # REST resources specific to Students at a given school
  class Student < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    NEW_FILTER = 'new'.freeze
    ACTIVE_FILTER = 'active'.freeze
    LOST_FILTER = 'lost'.freeze
    FROZEN_FILTER = 'frozen'.freeze
    ABSENT_FILTER = 'absent'.freeze

    def initialize(attributes = {}, persisted = false)
      attributes['inactivated_on'] = to_datetime(attributes['inactivated_on']) if attributes['inactivated_on'].present?
      attributes['converted_to_student_on'] = to_datetime(attributes['converted_to_student_on']) if attributes['converted_to_student_on'].present?

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
