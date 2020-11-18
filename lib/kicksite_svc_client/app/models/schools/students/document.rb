module Kicksite
  module Schools
    module Students
      # REST resources specific to Documents associated with given Student
      class Document < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/students/:student_id/'
        self.collection_parser = Kicksite::PaginatedCollection

        CREATED_AT_SORT_BY  = 'created_at'.freeze
        NAME_SORT_BY        = 'name'.freeze
      end
    end
  end
end
