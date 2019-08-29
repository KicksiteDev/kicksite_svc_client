module Schools
  # REST resources specific to Families at a given school
  class Family < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    def automations(options = {})
      return attributes['automations'] if options == {} && attributes.key?('automations')

      automations!(options)
    end

    def automations!(options = {})
      opt = options.dup
      opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
      opt = opt.deep_merge(params: { family_id: id })
      attributes['automations'] = Schools::Families::Automation.find(:all, opt)

      attributes['automations']
    end
  end
end
