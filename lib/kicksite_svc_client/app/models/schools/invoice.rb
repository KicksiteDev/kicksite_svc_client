require_relative '../../helpers/kicksite_svc_bearer_auth'
require_relative '../../helpers/paginated_collection'

module Schools
  # REST resources specific to Invoices at a given school
  class Invoice < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    INVOICE_DATETIME_KEYS = %w[
      date
      date_to_check_late_fees
      invoice_last_delivered
      receipt_last_emailed
      invoice_last_emailed
      recurred_at
      due_date
    ].freeze

    PAST_DUE_FILTER = 'past_due'.freeze
    DATE_SORT_BY = 'date'.freeze

    def initialize(attributes = {}, persisted = false)
      INVOICE_DATETIME_KEYS.each do |key|
        attributes[key] = to_datetime(attributes[key])
      end

      super(attributes, persisted)
    end

    def line_items(options = {})
      opt = options.dup
      opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
      opt = opt.deep_merge(params: { invoice_id: id })
      Schools::Invoices::LineItem.find(:all, opt)
    end
  end
end
