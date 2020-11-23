module Kicksite
  module Schools
    module People
      # REST resources specific to Programs associated with given person
      class Comments < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/people/:person_id/'
        self.collection_parser = Kicksite::PaginatedCollection
      end
    end
  end
end
