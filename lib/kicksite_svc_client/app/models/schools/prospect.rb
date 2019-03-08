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

    # Appointments associated with prospect.
    #
    # @param options [Hash] Options such as custom params
    # @return [PaginatedCollection] Collection of appointments associated with prospect
    def appointments(options = {})
      Schools::Prospects::Appointment.find(:all,
        options.deep_merge(params: {
                             school_id: prefix_options[:school_id],
                             prospect_id: id
                           })
      )
    end

    # Tasks associated with prospect.
    #
    # @param options [Hash] Options such as custom params
    # @return [PaginatedCollection] Collection of tasks associated with prospect
    def tasks(options = {})
      Schools::Prospects::Task.find(:all,
        options.deep_merge(params: {
                             school_id: prefix_options[:school_id],
                             prospect_id: id
                           })
      )
    end
  end
end
