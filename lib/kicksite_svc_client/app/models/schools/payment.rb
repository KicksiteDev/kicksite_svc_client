module Kicksite
  module Schools
    # REST resources specific to Payments at a given school
    class Payment < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
    end
  end
end
