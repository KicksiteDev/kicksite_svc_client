module Kicksite
  module Schools
    # REST resources specific to Invoices at a given school
    class Invoice < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection

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
        if persisted
          INVOICE_DATETIME_KEYS.each do |key|
            attributes[key] = to_datetime(attributes[key])
          end
        end

        super(attributes, persisted)
      end

      def line_items(options = {})
        return attributes['line_items'] if options == {} && attributes.key?('line_items')

        line_items!(options)
      end

      def line_items!(options = {})
        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { invoice_id: id })
        attributes['line_items'] = Kicksite::Schools::Invoices::LineItem.find(:all, opt)

        attributes['line_items']
      end
    end
  end
end
