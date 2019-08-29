module Schools
  # REST resources specific to Association Memberships at a given school
  class AssociationMembership < Schools::Membership
    def automations(options = {})
      return attributes['automations'] if options == {} && attributes.key?('automations')

      automations!(options)
    end

    def automations!(options)
      opt = options.dup
      opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
      opt = opt.deep_merge(params: { association_membership_id: id })
      attributes['automations'] = Schools::AssociationMemberships::Automation.find(:all, opt)

      attributes['automations']
    end
  end
end
