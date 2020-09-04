module Kicksite
  module Schools
    # REST resources specific to activity at a given school
    class Activity < Kicksite::NoSvcObject
      COMMENT_TYPE = 'comment'.freeze
      INVOICE_TYPE = 'invoice'.freeze
      PROSPECT_TYPE = 'prospect'.freeze
      PAYMENT_TYPE = 'payment'.freeze
      EVENT_TYPE = 'event'.freeze
      MEMBERSHIP_TYPE = 'membership'.freeze
      FAMILY_TYPE = 'family'.freeze
      STUDENT_TYPE = 'student'.freeze
      PROGRAM_TYPE = 'program'.freeze
      ATTENDANCE_TYPE = 'attendance'.freeze

      CREATE_ACTION = 'create'.freeze
      UPDATE_ACTION = 'update'.freeze
      DELETE_ACTION = 'delete'.freeze

      CREATED_AT_SORT_BY = 'created_at'.freeze

      # Generate filter syntax.
      #
      # @param type [String] default: nil Type of system event
      # @param action [String] default: nil Action that occurred that generated the system event
      # @return [String] Filter format this service expects
      def self.generate_filter(type = nil, action = nil)
        raise 'At least one of the available arguments is required' if type.nil? && action.nil?

        "#{type}:#{action}"
      end
    end
  end
end
