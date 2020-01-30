module Schools
  # REST resources specific to Families at a given school
  class Family < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection
  end
end
