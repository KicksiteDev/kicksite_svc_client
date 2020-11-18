module Kicksite
  module Schools
    module People
      # REST resources specific to Comments at a given school
      class Comment < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/people/:person_id'
      end
    end
  end
end
