require_relative '../../../helpers/kicksite_svc_bearer_auth'
require_relative '../../../helpers/paginated_collection'

module Schools
  module Invoices
    # REST resources specific to Line Items associated with given invoice
    class LineItem < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/invoices/:invoice_id/'
      self.collection_parser = PaginatedCollection
    end
  end
end
