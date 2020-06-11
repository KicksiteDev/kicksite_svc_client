module Kicksite
  module Schools
    # REST resources specific to Agreements at a given school
    class Agreement < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection
    end
  end
end
