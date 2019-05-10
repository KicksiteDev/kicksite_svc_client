require_relative '../../../helpers/kicksite_svc_bearer_auth'
require_relative '../../../helpers/paginated_collection'

module Schools
  module AssociationMemberships
    # REST resources specific to Automations associated with given Association Membership
    class Automation < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/association_memberships/:association_membership_id/'
      self.collection_parser = PaginatedCollection

      EXPIRING_AUTOMATION_TYPE = 'association_expiring_memberships'.freeze
      EXPIRED_AUTOMATION_TYPE = 'association_expired_memberships'.freeze
    end
  end
end
