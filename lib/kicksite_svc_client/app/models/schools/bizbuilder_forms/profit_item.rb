module Kicksite
  module Schools
    module BizbuilderForms
      # REST resources specific to Profit Items associated with given bizbuilder form
      class ProfitItem < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/bizbuilder_forms/:bizbuilder_form_id/'
        self.collection_parser = Kicksite::PaginatedCollection
      end
    end
  end
end
