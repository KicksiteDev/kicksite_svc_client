module Schools
  module People
    # REST resources specific to email addresses associated with given person
    class EmailAddress < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/people/:person_id/'
    end
  end
end
