module Kicksite
  module Schools
    module Students
      module Programs
        # REST resources specific to Attendance Awards in a Program for a given student
        class AttendanceAward < KicksiteSvcBearerAuth
          self.prefix = '/v1/schools/:school_id/students/:student_id/programs/:program_id/'
          self.collection_parser = Kicksite::PaginatedCollection
        end
      end
    end
  end
end
