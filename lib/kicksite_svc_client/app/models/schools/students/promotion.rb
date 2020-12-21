module Kicksite
  module Schools
    module Students
      # REST resources specific to promotions for given student
      class Promotion < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/students/:student_id/'
        self.collection_parser = Kicksite::PaginatedCollection

        def activate
          put(:activate)
        end
      end
    end
  end
end
