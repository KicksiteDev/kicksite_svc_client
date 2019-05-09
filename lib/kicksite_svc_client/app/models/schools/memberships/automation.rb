require_relative '../../../helpers/kicksite_svc_bearer_auth'
require_relative '../../../helpers/paginated_collection'

module Schools
  module Memberships
    # REST resources specific to Automations associated with given Membership
    class Automation < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/memberships/:membership_id/'
      self.collection_parser = PaginatedCollection

      EXPIRING_AUTOMATION_TYPE = 'expiring_memberships'.freeze
      EXPIRED_AUTOMATION_TYPE = 'expired_memberships'.freeze
    end
  end
end
