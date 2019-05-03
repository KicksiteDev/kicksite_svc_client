require_relative '../../../helpers/kicksite_svc_bearer_auth'
require_relative '../../../helpers/paginated_collection'

module Schools
  module Students
    # REST resources specific to Automations associated with given Student
    class Automation < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/students/:student_id/'
      self.collection_parser = PaginatedCollection

      ABSENT_STUDENTS_AUTOMATION_TYPE = 'absent_students'.freeze
      UPCOMING_BIRTHDAYS_AUTOMATION_TYPE = 'upcoming_birthdays'.freeze
      EXPIRING_MEMBERSHIPS_AUTOMATION_TYPE = 'expiring_memberships'.freeze
      EXPIRED_MEMBERSHIPS_AUTOMATION_TYPE = 'expired_memberships'.freeze
      ASSOCIATION_EXPIRING_MEMBERSHIPS_AUTOMATION_TYPE = 'association_expiring_memberships'.freeze
      ASSOCIATION_EXPIRED_MEMBERSHIPS_AUTOMATION_TYPE = 'association_expired_memberships'.freeze
    end
  end
end
