require_relative '../../helpers/kicksite_svc_bearer_auth'

module Schools
  # REST resources specific to Families at a given school
  class Family < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
  end
end
