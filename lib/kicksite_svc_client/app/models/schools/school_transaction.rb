module Kicksite
  module Schools
    # REST resources specific to School Transaction at a given school
    class SchoolTransaction < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
    end
  end
end
