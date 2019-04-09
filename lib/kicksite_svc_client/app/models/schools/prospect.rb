require_relative '../../helpers/paginated_collection'
require_relative '../../helpers/no_svc_object'
require_relative 'person.rb'

module Schools
  # REST resources specific to Prospects at a given school
  class Prospect < Schools::Person
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    class Source < NoSvcObject; end

    NOSHOW_STATE = 'noshow'.freeze
    LEAD_STATE = 'lead'.freeze
    APPOINTMENT_STATE = 'appointment'.freeze
    TRIAL_STATE = 'trial'.freeze
    ARCHIVED_STATE = 'archived'.freeze

    ACTIVE_FILTER = 'active'.freeze

    CREATED_AT_SORT_BY = 'created_at'.freeze

    # Appointments associated with prospect.
    #
    # @param options [Hash] Options such as custom params
    # @return [PaginatedCollection] Collection of appointments associated with prospect
    def appointments(options = {})
      opt = options.dup
      opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
      opt = opt.deep_merge(params: { prospect_id: id })
      Schools::Prospects::Appointment.find(:all, opt)
    end

    # Tasks associated with prospect.
    #
    # @param options [Hash] Options such as custom params
    # @return [PaginatedCollection] Collection of tasks associated with prospect
    def tasks(options = {})
      opt = options.dup
      opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
      opt = opt.deep_merge(params: { prospect_id: id })
      Schools::Prospects::Task.find(:all, opt)
    end

    # Method with which prospect entered the system.
    #
    # @return [Schools::Prospect::Source] Where source came from
    def source
      payload = get(:source)
      Schools::Prospect::Source.new(payload) if payload.present?
    end

    def photo
      payload = KicksiteSvcBearerAuth.get("schools/#{prefix_options[:school_id]}/people/#{id}/photo")
      Person::Photo.new(payload) if payload.present?
    end
  end
end
