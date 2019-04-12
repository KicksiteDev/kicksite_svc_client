require_relative '../../helpers/kicksite_svc_bearer_auth'

module Schools
  # REST resources specific to Memberships at a given school
  class Membership < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'

    EXPIRED_FILTER = 'expired'.freeze
    EXPIRING_FILTER = 'expiring'.freeze
    EXPIRED_AND_EXPIRING_FILTER = 'expired_expiring'.freeze

    # School membership is associated with.
    #
    # @return [School] School membership is associated with
    def school
      School.find(prefix_options[:school_id])
    end
  end
end
