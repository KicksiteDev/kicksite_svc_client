module Kicksite
  module Schools
    # REST resources specific to Students at a given school
    class Student < Kicksite::Schools::Person # rubocop:disable Metrics/ClassLength
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection

      class Guardian < Kicksite::NoSvcObject; end

      include Kicksite::Schools::Students::Constants

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

      def tasks(options = {})
        return attributes['tasks'] if options == {} && attributes.key?('tasks')

        tasks!(options)
      end

      def tasks!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })
        attributes['tasks'] = Kicksite::Schools::Students::Task.find(:all, opt)

        attributes['tasks']
      end

      def self.tasks(options = {})
        opt = options.dup
        opt = { params: opt } if opt.keys.count != 1 && !opt.key?('params') && !opt.key?(:params)
        opt = opt.deep_merge(params: { subject_type: 'Student' })

        Kicksite::Schools::Task.find(:all, opt)
      end

      def agreements(options = {})
        return attributes['agreements'] if options == {} && attributes.key?('agreements')

        agreements!(options)
      end

      def agreements!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })
        attributes['agreements'] = Kicksite::Schools::Students::Agreement.find(:all, opt)

        attributes['agreements']
      end

      def documents(options = {})
        return attributes['documents'] if options == {} && attributes.key?('documents')

        documents!(options)
      end

      def documents!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })
        attributes['documents'] = Kicksite::Schools::Students::Document.find(:all, opt)

        attributes['documents']
      end

      def automations(options = {})
        return attributes['automations'] if options == {} && attributes.key?('automations')

        automations!(options)
      end

      def automations!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })
        attributes['automations'] = Kicksite::Schools::Students::Automation.find(:all, opt)

        attributes['automations']
      end

      # Appointments associated with student.
      #
      # @param options [Hash] Options such as custom params
      # @return [Kicksite::PaginatedCollection] Collection of appointments associated with student
      def appointments(options = {})
        return attributes['appointments'] if options == {} && attributes.key?('appointments')

        appointments!(options)
      end

      def appointments!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })
        attributes['appointments'] = Kicksite::Schools::Students::Appointment.find(:all, opt)

        attributes['appointments']
      end

      def self.appointments(options = {})
        opt = options.dup
        opt = { params: opt } if opt.keys.count != 1 && !opt.key?('params') && !opt.key?(:params)
        opt = opt.deep_merge(params: { subject_type: 'Student' })

        Kicksite::Schools::Appointment.find(:all, opt)
      end

      def attendances(options = {})
        return attributes['attendances'] if options == {} && attributes.key?('attendances')

        attendances!(options)
      end

      def attendances!(options = {})
        opt = options.dup
        opt = { params: opt } if opt.keys.count != 1 && !opt.key?('params') && !opt.key?(:params)
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { subject_id: id })
        opt = opt.deep_merge(params: { subject_type: 'students' })

        Kicksite::Schools::People::Programs::Attendance.find(:all, opt)
      end

      def events(options = {})
        return attributes['events'] if options == {} && attributes.key?('events')

        events!(options)
      end

      def events!(options = {})
        opt = options.dup
        opt = { params: opt } if opt.keys.count != 1 && !opt.key?('params') && !opt.key?(:params)
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })

        Kicksite::Schools::Students::Event.find(:all, opt)
      end

      def event_registrations(options = {})
        return attributes['event_registrations'] if options == {} && attributes.key?('event_registrations')

        event_registrations!(options)
      end

      def event_registrations!(options = {})
        opt = options.dup
        opt = { params: opt } if opt.keys.count != 1 && !opt.key?('params') && !opt.key?(:params)
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })

        Kicksite::Schools::Students::EventRegistration.find(:all, opt)
      end

      def programs(options = {})
        return attributes['programs'] if options == {} && attributes.key?('programs')

        programs!(options)
      end

      def programs!(options = {})
        opt = options.dup
        opt = { params: opt } if opt.keys.count != 1 && !opt.key?('params') && !opt.key?(:params)
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { person_id: id })

        Kicksite::Schools::People::Program.find(:all, opt)
      end

      def memberships!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })
        attributes['memberships'] = Kicksite::Schools::Students::Membership.find(:all, opt)

        attributes['memberships']
      end

      def memberships(options = {})
        return attributes['memberships'] if options == {} && attributes.key?('memberships')

        memberships!(options)
      end

      def self.memberships(options = {})
        payload = KicksiteSvcBearerAuth.get("schools/#{options[:school_id]}/students/memberships", options)
        Kicksite::PaginatedCollection.new(
          payload.map { |item| Kicksite::Schools::Students::Membership.new(item, true) }
        )
      end

      def progression_levels(options = {})
        return attributes['progression_levels'] if options == {} && attributes.key?('progression_levels')

        progression_levels!(options)
      end

      def progression_levels!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })
        attributes['progression_levels'] = Kicksite::Schools::Students::ProgressionLevel.find(:all, opt)

        attributes['progression_levels']
      end

      def attendance_awards(options = {})
        return attributes['attendance_awards'] if options == {} && attributes.key?('attendance_awards')

        attendance_awards!(options)
      end

      def attendance_awards!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })
        attributes['attendance_awards'] = Kicksite::Schools::Students::Programs::AttendanceAward.find(:all, opt)

        attributes['attendance_awards']
      end

      def promotions(options = {})
        return attributes['promotions'] if options == {} && attributes.key?('promotions')

        promotions!(options)
      end

      def promotions!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { student_id: id })
        attributes['promotions'] = Kicksite::Schools::Students::Promotion.find(:all, opt)

        attributes['promotions']
      end
    end
  end
end
