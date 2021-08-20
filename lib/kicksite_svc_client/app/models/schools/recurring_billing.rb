module Kicksite
  module Schools
    # REST resources specific to Recurring Billings at a given school
    class RecurringBilling < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection

      RECURRING_BILLING_DATETIME_KEYS = %w[
        inactivated_at
        last_decline_at
        paid_through
        start_date
        end_date
      ].freeze

      ACTIVE_FILTER = 'active'.freeze
      ACTIVE_NOVAULT_FILTER = 'active-novault'.freeze
      ACTIVE_UNPAID_FILTER = 'active-unpaid'.freeze
      COMPLETED_FILTER = 'completed'.freeze
      INACTIVE_UNPAID_FILTER = 'inactive-unpaid'.freeze

      NAME_SORT_BY = 'name'.freeze
      PAID_THROUGH_SORT_BY = 'paid_through'.freeze

      def initialize(attributes = {}, persisted = false)
        if persisted
          RECURRING_BILLING_DATETIME_KEYS.each do |key|
            attributes[key] = to_datetime(attributes[key])
          end
        end

        super(attributes, persisted)
      end
    end
  end
end
