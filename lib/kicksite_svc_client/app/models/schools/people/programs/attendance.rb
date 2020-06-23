module Kicksite
  module Schools
    module People
      module Programs
        # REST resources specific to Attendances associated with given person
        class Attendance < KicksiteSvcBearerAuth
          self.prefix = '/v1/schools/:school_id/:subject_type/:subject_id/programs/:program_id/'
        end
      end
    end
  end
end
