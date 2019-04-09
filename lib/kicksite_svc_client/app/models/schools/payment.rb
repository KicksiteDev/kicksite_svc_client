require_relative '../../helpers/kicksite_svc_bearer_auth'

module Schools
  # REST resources specific to Payments at a given school
  class Payment < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
  end
end
