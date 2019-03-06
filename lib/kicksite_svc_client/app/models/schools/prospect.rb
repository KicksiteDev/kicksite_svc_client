require_relative '../../helpers/kicksite_svc_bearer_auth'
require_relative '../../helpers/paginated_collection'

module Schools
  # REST resources specific to Prospects at a given school
  class Prospect < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    PROSPECT_DATETIME_KEYS = %w[
      inactivated_on
      converted_to_prospect_on
    ].freeze

    NOSHOW_STATE = 'noshow'.freeze
    LEAD_STATE = 'lead'.freeze
    APPOINTMENT_STATE = 'appointment'.freeze
    TRIAL_STATE = 'trial'.freeze
    ARCHIVED_STATE = 'archived'.freeze

    CREATED_AT_SORT_BY = 'created_at'.freeze

    def initialize(attributes = {}, persisted = false)
      PROSPECT_DATETIME_KEYS.each do |key|
        attributes[key] = to_datetime(attributes[key])
      end

      super(attributes, persisted)
    end

    # School prospect is associated with.
    #
    # @return [School] School prospect is associated with
    def school
      School.find(prefix_options[:school_id])
    end
  end
end
