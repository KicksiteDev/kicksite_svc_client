module Kicksite
  module Schools
    # REST resources specific to Memberships at a given school
    class Membership < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection
    end
  end
end
