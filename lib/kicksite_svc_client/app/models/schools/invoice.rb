require_relative '../../helpers/kicksite_svc_bearer_auth'

module Schools
  # REST resources specific to Invoices at a given school
  class Invoice < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
  end
end
