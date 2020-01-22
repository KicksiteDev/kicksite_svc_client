module Schools
  module Bizbuilder
    # A lead capture form thing
    class LandingPage < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/bizbuilder/'
      self.collection_parser = PaginatedCollection
    end
  end
end
