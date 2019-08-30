module Schools
  module People
    # REST resources specific to phone numbers associated with given person
    class PhoneNumber < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/people/:person_id/'
    end
  end
end
