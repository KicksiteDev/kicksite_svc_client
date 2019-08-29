module Schools
  # REST resources specific to Events at a given school
  class Event < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
  end
end
