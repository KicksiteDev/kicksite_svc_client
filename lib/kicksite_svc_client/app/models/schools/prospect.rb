require_relative '../../helpers/kicksite_svc_bearer_auth'
require_relative '../../helpers/paginated_collection'

module Schools
  # REST resources specific to Prospects at a given school
  class Prospect < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    class Source < NoSvcObject; end

    PROSPECT_DATETIME_KEYS = %w[
      inactivated_on
      converted_to_prospect_on
    ].freeze

    NOSHOW_STATE = 'noshow'.freeze
    LEAD_STATE = 'lead'.freeze
    APPOINTMENT_STATE = 'appointment'.freeze
    TRIAL_STATE = 'trial'.freeze
    ARCHIVED_STATE = 'archived'.freeze

    ACTIVE_FILTER = 'active'.freeze

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
      options.deep_merge(params: { school_id: prefix_options[:school_id] })
      options.deep_merge(params: { prospect_id: id })
      Schools::Prospects::Appointment.find(:all, options)
    end

    # Tasks associated with prospect.
    #
    # @param options [Hash] Options such as custom params
    # @return [PaginatedCollection] Collection of tasks associated with prospect
    def tasks(options = {})
      options.deep_merge(params: { school_id: prefix_options[:school_id] })
      options.deep_merge(params: { prospect_id: id })
      Schools::Prospects::Task.find(:all, options)
    end

    # Method with which prospect entered the system.
    #
    # @return [Schools::Prospect::Source] Where source came from
    def source
      payload = get(:source)
      Schools::Prospect::Source.new(payload) if payload.present?
    end
  end
end
