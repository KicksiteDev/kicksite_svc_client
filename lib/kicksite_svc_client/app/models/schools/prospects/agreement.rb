module Kicksite
  module Schools
    module Prospects
      # REST resources specific to Agreements associated with given Prospect
      class Agreement < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/prospects/:prospect_id/'
      end
    end
  end
end
