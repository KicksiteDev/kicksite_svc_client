module Kicksite
  module Schools
    module Invoices
      # REST resources specific to Line Items associated with given invoice
      class LineItem < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/invoices/:invoice_id/'
        self.collection_parser = Kicksite::PaginatedCollection
      end
    end
  end
end
