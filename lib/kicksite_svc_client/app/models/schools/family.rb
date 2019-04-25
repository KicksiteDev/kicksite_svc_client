require_relative '../../helpers/kicksite_svc_bearer_auth'

module Schools
  # REST resources specific to Families at a given school
  class Family < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'

    def automations(options = {})
      opt = options.dup
      opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
      opt = opt.deep_merge(params: { family_id: id })
      Schools::Families::Automation.find(:all, opt)
    end
  end
end
