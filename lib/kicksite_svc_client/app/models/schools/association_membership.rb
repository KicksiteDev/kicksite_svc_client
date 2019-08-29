module Schools
  # REST resources specific to Association Memberships at a given school
  class AssociationMembership < Schools::Membership
    def automations(options = {})
      opt = options.dup
      opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
      opt = opt.deep_merge(params: { association_membership_id: id })
      Schools::AssociationMemberships::Automation.find(:all, opt)
    end
  end
end
