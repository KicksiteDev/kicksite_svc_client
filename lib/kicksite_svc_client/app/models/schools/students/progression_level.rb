module Schools
  module Students
    # REST resources specific to Progression Levels at a given school
    class ProgressionLevel < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/students/'
      self.collection_parser = PaginatedCollection
    end
  end
end
