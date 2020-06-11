module Kicksite
  module Schools
    # REST resources specific to Inventory at a given school
    class Inventory < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
      self.collection_name = 'inventory'
      self.collection_parser = Kicksite::PaginatedCollection
      self.element_name = 'inventory'
    end
  end
end
