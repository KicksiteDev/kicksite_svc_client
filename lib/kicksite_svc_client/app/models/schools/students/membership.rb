module Kicksite
  module Schools
    module Students
      # REST resources specific to Memberships at a given school
      class Membership < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/students/:student_id/'
        self.collection_parser = Kicksite::PaginatedCollection

        EXPIRED_FILTER = 'expired'.freeze
        EXPIRING_FILTER = 'expiring'.freeze
        EXPIRED_AND_EXPIRING_FILTER = 'expired_expiring'.freeze

        ASSOCIATION_TYPE = 'association'.freeze

        CREATED_AT_SORT_BY = 'created_at'.freeze
        EXPIRATION_DATE_SORT_BY = 'expiration_date'.freeze

        MEMBERSHIP_DATETIME_KEYS = %w[
          start_date
          end_date
        ].freeze

        def initialize(attributes = {}, persisted = false)
          if persisted
            MEMBERSHIP_DATETIME_KEYS.each do |key|
              attributes[key] = to_datetime(attributes[key])
            end
          end

          super(attributes, persisted)
        end
      end
    end
  end
end
