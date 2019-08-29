module Schools
  # REST resources specific to employees at a given school
  class Employee < Schools::Person
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    ACTIVE_FILTER = 'active'.freeze

    CREATED_AT_SORT_BY = 'created_at'.freeze

    def photo
      payload = KicksiteSvcBearerAuth.get("schools/#{prefix_options[:school_id]}/people/#{id}/photo")
      Person::Photo.new(payload, true) if payload.present?
    end
  end
end
