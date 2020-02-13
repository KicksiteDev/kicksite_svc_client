module Schools
  # REST resources specific to Agreements at a given school
  class Agreement < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection
  end
end