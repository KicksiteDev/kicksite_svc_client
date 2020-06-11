module Kicksite
  module Schools
    # REST resources specific to Bizbuilder Forms at a given school
    class BizbuilderForm < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection

      def find(*arguments)
        warn '[DEPRECATION] `BizbuilderForm.find` is deprecated. New structure coming soon.'

        super(arguments)
      end

      # Profit items associated with bizbuilder.
      #
      # @param options [Hash] Options such as custom params
      # @return [Kicksite::PaginatedCollection] Collection of profit items associated with bizbuilder form
      def profit_items(options = {})
        return attributes['profit_items'] if options == {} && attributes.key?('profit_items')

        profit_items!(options)
      end

      def profit_items!(options = {})
        warn '[DEPRECATION] `BizbuilderForm.profit_items!` is deprecated. New structure coming soon.'

        opt = options.dup
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
        opt = opt.deep_merge(params: { bizbuilder_form_id: id })
        attributes['profit_items'] = Kicksite::Schools::BizbuilderForms::ProfitItem.find(:all, opt)

        attributes['profit_items']
      end
    end
  end
end
