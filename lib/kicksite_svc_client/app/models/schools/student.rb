require_relative '../../helpers/paginated_collection'
require_relative 'person.rb'

module Schools
  # REST resources specific to Students at a given school
  class Student < Schools::Person
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    NEW_FILTER = 'new'.freeze
    ACTIVE_FILTER = 'active'.freeze
    LOST_FILTER = 'lost'.freeze
    FROZEN_FILTER = 'frozen'.freeze
    ABSENT_FILTER = 'absent'.freeze

    def photo
      payload = KicksiteSvcBearerAuth.get("schools/#{prefix_options[:school_id]}/people/#{id}/photo")
      Person::Photo.new(payload) if payload.present?
    end
  end
end
