module Kicksite
  module Schools
    module Prospects
      # REST resources specific to Tasks associated with given prospect
      class Task < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/prospects/:prospect_id/'
        self.collection_parser = Kicksite::PaginatedCollection

        class Aggregation < Kicksite::NoSvcObject; end

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
          opt = opt.deep_merge(subject_type: 'Prospect')

          payload = KicksiteSvcBearerAuth.get("schools/#{opt[:school_id]}/task/aggregations/#{type}", opt)
          payload.map { |item| Kicksite::Schools::Prospects::Task::Aggregation.new(item, true) }
        end
      end
    end
  end
end
