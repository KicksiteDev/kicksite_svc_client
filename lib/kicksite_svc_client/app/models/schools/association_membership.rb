require_relative '../../helpers/kicksite_svc_bearer_auth'
require_relative '../../helpers/paginated_collection'
require_relative 'membership'

module Schools
  # REST resources specific to Association Memberships at a given school
  class AssociationMembership < Schools::Membership
  end
end
