module Kicksite
  module Schools
    # REST resources specific to Prospects at a given school
    class Prospect < Kicksite::Schools::Person # rubocop:disable Metrics/ClassLength
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection

      class Source < Kicksite::NoSvcObject; end

      NOSHOW_STATE = 'noshow'.freeze
      LEAD_STATE = 'lead'.freeze
      APPOINTMENT_STATE = 'appointment'.freeze
      TRIAL_STATE = 'trial'.freeze
      ARCHIVED_STATE = 'archived'.freeze

      ACTIVE_FILTER = 'active'.freeze

      CREATED_AT_SORT_BY    = 'created_at'.freeze
      FIRST_NAME_SORT_BY    = 'first_name'.freeze
      LAST_NAME_SORT_BY     = 'last_name'.freeze
      SOURCE_SORT_BY        = 'source'.freeze
      APPOINTMENTS_SORT_BY  = 'appointments'.freeze
      OVERDUE_TASK_SORT_BY  = 'overdue_task'.freeze
      NO_SHOW_SORT_BY       = 'noshow'.freeze
      ASSIGNED_TO_SORT_BY   = 'assigned_to'.freeze

      # Agreements associated with prospect.
      #
      # @param options [Hash] Options such as custom params
      # @return [Kicksite::PaginatedCollection] Collection of agreements associated with prospect
      def agreements(options = {})
        return attributes['agreements'] if options == {} && attributes.key?('agreements')

        agreements!(options)
      end

      def agreements!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { prospect_id: id })
        attributes['agreements'] = Kicksite::Schools::Prospects::Agreement.find(:all, opt)

        attributes['agreements']
      end

      # Appointments associated with prospect.
      #
      # @param options [Hash] Options such as custom params
      # @return [Kicksite::PaginatedCollection] Collection of appointments associated with prospect
      def appointments(options = {})
        return attributes['appointments'] if options == {} && attributes.key?('appointments')

        appointments!(options)
      end

      def appointments!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { prospect_id: id })
        attributes['appointments'] = Kicksite::Schools::Prospects::Appointment.find(:all, opt)

        attributes['appointments']
      end

      def comments(options = {})
        return attributes['comments'] if options == {} && attributes.key?('comments')

        comments!(options)
      end

      def comments!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })
        opt = opt.deep_merge(params: { employee_id: opt[:employee_id] }) if opt.try(:[], :employee_id).present?
        attributes['comments'] = Kicksite::Schools::People::Comments.find(:all, opt)

        attributes['comments']
      end

      # Tasks associated with prospect.
      #
      # @param options [Hash] Options such as custom params
      # @return [Kicksite::PaginatedCollection] Collection of tasks associated with prospect
      def tasks(options = {})
        return attributes['tasks'] if options == {} && attributes.key?('tasks')

        tasks!(options)
      end

      def tasks!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { prospect_id: id })
        attributes['tasks'] = Kicksite::Schools::Prospects::Task.find(:all, opt)

        attributes['tasks']
      end

      # Memberships associated with prospect.
      #
      # @param options [Hash] Options such as custom params
      # @return [Kicksite::PaginatedCollection] Collection of memberships associated with prospect
      def memberships(options = {})
        return attributes['memberships'] if options == {} && attributes.key?('memberships')

        memberships!(options)
      end

      def memberships!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { prospect_id: id })
        attributes['memberships'] = Kicksite::Schools::Prospects::Membership.find(:all, opt)

        attributes['memberships']
      end

      # Attendances associated with prospect.
      #
      # @param options [Hash] Options such as custom params
      # @return [Kicksite::PaginatedCollection] Collection of attendances associated with prospect
      def attendances(options = {})
        return attributes['attendances'] if options == {} && attributes.key?('attendances')

        attendances!(options)
      end

      def attendances!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { prospect_id: id })
        attributes['attendances'] = Kicksite::Schools::Prospects::Attendance.find(:all, opt)

        attributes['attendances']
      end

      # Method with which prospect entered the system.
      #
      # @return [Kicksite::Schools::Prospect::Source] Where source came from
      def source
        return attributes['source'] if attributes.key?('source')

        source!
      end

      def source!
        payload = get(:source)
        attributes['source'] = payload.present? ? Kicksite::Schools::Prospect::Source.new(payload, true) : nil

        attributes['source']
      end

      def photo!
        payload = KicksiteSvcBearerAuth.get("schools/#{prefix_options[:school_id]}/people/#{id}/photo")
        attributes['photo'] = payload.present? ? Person::Photo.new(payload, true) : nil

        attributes['photo']
      end

      def history!(options = {})
        payload = KicksiteSvcBearerAuth.get("schools/#{prefix_options[:school_id]}/people/#{id}/history", options)
        attributes['history'] =
          Kicksite::PaginatedCollection.new(payload.map do |event|
            Kicksite::Schools::Person::History.new(event, true)
          end)

        attributes['history']
      end

      def self.tasks(options = {})
        opt = options.dup
        opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
        opt = opt.deep_merge(params: { subject_type: 'Prospect' })

        Kicksite::Schools::Task.find(:all, opt)
      end

      def self.appointments(options = {})
        opt = options.dup
        opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
        opt = opt.deep_merge(params: { subject_type: 'Prospect' })

        Kicksite::Schools::Appointment.find(:all, opt)
      end
    end
  end
end
