module Kicksite
  module Schools
    # REST resources specific to tasks at a given school
    class Task < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection
    end
  end
end
