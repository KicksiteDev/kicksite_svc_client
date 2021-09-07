module Kicksite
  module Schools
    module Prospects
      # REST resources specific to Events associated with given Student
      class EventRegistration < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/prospects/:prospect_id/'
        self.collection_parser = Kicksite::PaginatedCollection
      end
    end
  end
end
