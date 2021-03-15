module Kicksite
  module Schools
    module Students
      # REST resources specific to Agreements associated with given Student
      class Agreement < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/students/:student_id/'
        self.collection_parser = Kicksite::PaginatedCollection

        ACTIVE_FILTER = 'active'.freeze

        CREATED_AT_SORT_BY  = 'created_at'.freeze
        DATE_SIGNED_SORT_BY = 'date_signed'.freeze
        NAME_SORT_BY        = 'name'.freeze
        STATUS_SORT_BY      = 'status'.freeze

        def initialize(payload = {}, persisted = false)
          if persisted
            BASE_DATETIME_KEYS.each do |key|
              payload[key] = to_datetime(payload[key]) if payload[key].present?
            end
          end

          payload.each do |key, value|
            recursive_define(key, value)
          end
        end

        def sign(file:)
          begin
            sign!(file: file)
          rescue StandardError
            return false
          end

          true
        end

        def sign!(file:)
          KicksiteSvcBearerAuth.put("schools/#{school_id}/students/#{student_id}/agreements/#{id}/sign", {file: file})
        end
      end
    end
  end
end
