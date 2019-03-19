require_relative '../../helpers/kicksite_svc_bearer_auth'
require_relative '../../helpers/paginated_collection'

module Schools
  # REST resources specific to Bizbuilder Forms at a given school
  class BizbuilderForm < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    # Profit items associated with bizbuilder.
    #
    # @param options [Hash] Options such as custom params
    # @return [PaginatedCollection] Collection of profit items associated with bizbuilder form
    def profit_items(options = {})
      options.deep_merge(params: { school_id: prefix_options[:school_id] })
      options.deep_merge(params: { bizbuilder_form_id: id })
      Schools::BizbuilderForms::ProfitItem.find(:all, options)
    end
  end
end
