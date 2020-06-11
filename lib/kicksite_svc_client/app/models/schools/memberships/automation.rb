module Kicksite
  module Schools
    module Memberships
      # REST resources specific to Automations associated with given Membership
      class Automation < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/memberships/:membership_id/'
        self.collection_parser = Kicksite::PaginatedCollection

        EXPIRING_AUTOMATION_TYPE = 'expiring_memberships'.freeze
        EXPIRED_AUTOMATION_TYPE = 'expired_memberships'.freeze
      end
    end
  end
end
