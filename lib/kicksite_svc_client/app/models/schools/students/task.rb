module Schools
  module Students
    # REST resources specific to Tasks associated with given student
    class Task < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/students/:student_id/'
      self.collection_parser = PaginatedCollection

      class Aggregation < NoSvcObject; end

      TASK_DATETIME_KEYS = %w[
        due_at
      ].freeze

      PAST_FILTER = 'past'.freeze
      FUTURE_FILTER = 'future'.freeze
      COMPLETE_FILTER = 'complete'.freeze
      INCOMPLETE_FILTER = 'incomplete'.freeze

      DUE_AT_SORT_BY = 'due_at'.freeze

      def initialize(attributes = {}, persisted = false)
        if persisted
          TASK_DATETIME_KEYS.each do |key|
            attributes[key] = to_datetime(attributes[key])
          end
        end

        super(attributes, persisted)
      end

      def self.aggregation(type, options = {})
        opt = options.dup
        opt = opt.deep_merge(subject_type: 'Student')

        payload = KicksiteSvcBearerAuth.get("schools/#{opt[:school_id]}/task/aggregations/#{type}", opt)
        payload.map { |item| Schools::Students::Task::Aggregation.new(item, true) }
      end
    end
  end
end
