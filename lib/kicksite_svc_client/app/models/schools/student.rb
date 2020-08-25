module Kicksite
  module Schools
    # REST resources specific to Students at a given school
    class Student < Kicksite::Schools::Person # rubocop:disable Metrics/ClassLength
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection

      include Kicksite::Schools::Students::Constants

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
        opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
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
        opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
        opt = opt.deep_merge(params: { subject_type: 'Student' })

        Kicksite::Schools::Appointment.find(:all, opt)
      end

      def attendances(options = {})
        return attributes['attendances'] if options == {} && attributes.key?('attendances')

        attendances!(options)
      end

      def attendances!(options = {})
        opt = options.dup
        opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { subject_id: id })
        opt = opt.deep_merge(params: { subject_type: 'students' })

        Kicksite::Schools::People::Programs::Attendance.find(:all, opt)
      end

      def programs(options = {})
        return attributes['programs'] if options == {} && attributes.key?('programs')

        programs!(options)
      end

      def programs!(options = {})
        opt = options.dup
        opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
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

      def toggle_recurring_billings
        KicksiteSvcBearerAuth.post(
          "schools/#{prefix_options[:school_id]}/students/#{id}/toggle_recurring_billings"
        )
      end
    end
  end
end
