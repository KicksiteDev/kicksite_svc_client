module Schools
  module Students
    # REST resources specific to Automations associated with given Student
    class Membership < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/students/:student_id/'
      self.collection_parser = PaginatedCollection
    end
  end
end
