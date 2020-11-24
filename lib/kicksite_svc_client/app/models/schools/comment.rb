module Kicksite
  module Schools
    # REST resources specific to Comments at a given school
    class Comment < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection
    end
  end
end
