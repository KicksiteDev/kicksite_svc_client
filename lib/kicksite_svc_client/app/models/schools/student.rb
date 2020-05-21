module Schools
  # REST resources specific to Students at a given school
  class Student < Schools::Person
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    NEW_FILTER = 'new'.freeze
    ACTIVE_FILTER = 'active'.freeze
    ACTIVE_WITHOUT_FROZEN = 'active_without_frozen'.freeze
    LOST_FILTER = 'lost'.freeze
    INACTIVE_FILTER = 'inactive'.freeze
    FROZEN_FILTER = 'frozen'.freeze
    ABSENT_FILTER = 'absent'.freeze
    HAS_BIRTHDAY_FILTER = 'has_birthday'.freeze
    HAS_BIRTHDAY_AND_IS_ACTIVE_FILTER = 'has_birthday_and_is_active'.freeze

    CREATED_AT_SORT_BY = 'created_at'.freeze
    BIRTHDATE_SORT_BY = 'birthdate'.freeze
    NEXT_BIRTHDAY_SORT_BY = 'next_birthday'.freeze

    def photo!
      payload = KicksiteSvcBearerAuth.get("schools/#{prefix_options[:school_id]}/people/#{id}/photo")
      attributes['photo'] = payload.present? ? Person::Photo.new(payload, true) : nil

      attributes['photo']
    end

    def automations(options = {})
      return attributes['automations'] if options == {} && attributes.key?('automations')

      automations!(options)
    end

    def automations!(options = {})
      opt = options.dup
      opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
      opt = opt.deep_merge(params: { student_id: id })
      attributes['automations'] = Schools::Students::Automation.find(:all, opt)

      attributes['automations']
    end

    # Appointments associated with student.
    #
    # @param options [Hash] Options such as custom params
    # @return [PaginatedCollection] Collection of appointments associated with student
    def appointments(options = {})
      return attributes['appointments'] if options == {} && attributes.key?('appointments')

      appointments!(options)
    end

    def appointments!(options = {})
      opt = options.dup
      opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
      opt = opt.deep_merge(params: { student_id: id })
      attributes['appointments'] = Schools::Students::Appointment.find(:all, opt)

      attributes['appointments']
    end

    def self.memberships(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      Schools::Students::Membership.find(:all, opt)
    end

    def self.appointments(options = {})
      opt = options.dup
      opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
      opt = opt.deep_merge(params: { subject_type: 'Student' })

      Schools::Appointment.find(:all, opt)
    end
  end
end
