module Schools
  module Prospects
    # REST resources specific to Memberships associated with given prospect
    class Membership < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/prospects/:prospect_id/'
      self.collection_parser = PaginatedCollection

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
