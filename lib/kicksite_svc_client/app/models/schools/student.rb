require_relative '../../helpers/kicksite_svc_basic_auth'

module Schools
  # REST resources specific to Students at a given school
  class Student < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
  end
end
