module Kicksite
  module Schools
    module Students
      # REST resources specific to Agreements associated with given Student
      class Agreement < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/students/:student_id/'
        self.collection_parser = Kicksite::PaginatedCollection

        ACTIVE_FILTER = 'active'.freeze
      end
    end
  end
end
