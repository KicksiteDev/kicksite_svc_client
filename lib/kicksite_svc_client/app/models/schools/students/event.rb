module Kicksite
  module Schools
    module Students
      # REST resources specific to Events associated with given Student
      class Event < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/students/:student_id/'
        self.collection_parser = Kicksite::PaginatedCollection
      end
    end
  end
end
