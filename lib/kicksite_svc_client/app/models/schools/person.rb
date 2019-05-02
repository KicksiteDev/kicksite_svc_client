require_relative '../../helpers/kicksite_svc_bearer_auth'
require_relative '../../helpers/no_svc_object'
require_relative '../../helpers/paginated_collection'

module Schools
  # REST resources specific to People at a given school
  class Person < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    class Photo < NoSvcObject; end

    PERSON_DATETIME_KEYS = %w[
      inactivated_on
      converted_to_prospect_on
      converted_to_student_on
    ].freeze

    def initialize(attributes = {}, persisted = false)
      PERSON_DATETIME_KEYS.each do |key|
        attributes[key] = to_datetime(attributes[key])
      end

      super(attributes, persisted)
    end

    def photo
      payload = get(:photo)
      Person::Photo.new(payload) if payload.present?
    end

    def phone_numbers(options = {})
      params = { school_id: prefix_options[:school_id], person_id: id }
      Schools::People::PhoneNumber.find(:all, options.deep_merge(params: params))
    end

    # School person is associated with.
    #
    # @return [School] School person is associated with
    def school
      School.find(prefix_options[:school_id])
    end
  end
end
