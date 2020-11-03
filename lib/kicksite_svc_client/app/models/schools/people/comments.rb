module Kicksite
  module Schools
    module People
      # REST resources specific to Programs associated with given person
      class Comments < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/people/:person_id/'
      end
    end
  end
end
