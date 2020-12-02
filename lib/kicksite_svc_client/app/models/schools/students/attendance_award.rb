module Kicksite
  module Schools
    module Students
      # REST resources specific to Attendance Awards for given student
      class AttendanceAward < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/students/:student_id/'
        self.collection_parser = Kicksite::PaginatedCollection
      end
    end
  end
end
