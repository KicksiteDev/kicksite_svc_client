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
    HAS_BIRTHDAY_FILTER = 'has_birthday'.freeze
    HAS_BIRTHDAY_AND_IS_ACTIVE_FILTER = 'has_birthday_and_is_active'.freeze

    CREATED_AT_SORT_BY = 'created_at'.freeze
    BIRTHDATE_SORT_BY = 'birthdate'.freeze
    NEXT_BIRTHDAY_SORT_BY = 'next_birthday'.freeze

    def photo
      payload = KicksiteSvcBearerAuth.get("schools/#{prefix_options[:school_id]}/people/#{id}/photo")
      Person::Photo.new(payload) if payload.present?
    end

    def automations(options = {})
      opt = options.dup
      opt = opt.deep_merge(params: { school_id: prefix_options[:school_id] })
      opt = opt.deep_merge(params: { student_id: id })
      Schools::Students::Automation.find(:all, opt)
    end
  end
end
