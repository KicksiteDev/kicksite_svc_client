require_relative '../../../helpers/kicksite_svc_bearer_auth'
require_relative '../../../helpers/paginated_collection'

module Schools
  module BizbuilderForms
    # REST resources specific to Profit Items associated with given bizbuilder form
    class ProfitItem < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/bizbuilder_forms/:bizbuilder_form_id/'
      self.collection_parser = PaginatedCollection
    end
  end
end
