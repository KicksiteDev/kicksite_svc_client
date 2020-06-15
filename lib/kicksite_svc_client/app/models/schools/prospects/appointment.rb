module Kicksite
  module Schools
    module Prospects
      # REST resources specific to Appointments associated with given prospect
      class Appointment < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/prospects/:prospect_id/'
        self.collection_parser = Kicksite::PaginatedCollection

        class Aggregation < Kicksite::NoSvcObject; end

        APPOINTMENT_DATETIME_KEYS = %w[
          start_at
          end_at
        ].freeze

        PAST_FILTER = 'past'.freeze
        FUTURE_FILTER = 'future'.freeze
        COMPLETE_FILTER = 'complete'.freeze
        INCOMPLETE_FILTER = 'incomplete'.freeze

        START_AT_SORT_BY = 'start_at'.freeze

        def initialize(attributes = {}, persisted = false)
          if persisted
            APPOINTMENT_DATETIME_KEYS.each do |key|
              attributes[key] = to_datetime(attributes[key])
            end
          end

          super(attributes, persisted)
        end

        def self.aggregation(type, options = {})
          opt = options.dup
          opt = opt.deep_merge(subject_type: 'Prospect')

          payload = KicksiteSvcBearerAuth.get("schools/#{opt[:school_id]}/appointment/aggregations/#{type}", opt)
          payload.map { |item| Kicksite::Schools::Prospects::Appointment::Aggregation.new(item, true) }
        end
      end
    end
  end
end
