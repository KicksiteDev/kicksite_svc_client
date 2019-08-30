module Schools
  module Prospects
    # REST resources specific to Tasks associated with given prospect
    class Task < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/prospects/:prospect_id/'
      self.collection_parser = PaginatedCollection

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
    end
  end
end
