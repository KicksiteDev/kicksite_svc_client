module Kicksite
  module Schools
    # REST resources specific to appointments at a given school
    class Appointment < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection
    end
  end
end
