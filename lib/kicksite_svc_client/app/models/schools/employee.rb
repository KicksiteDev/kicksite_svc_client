module Kicksite
  module Schools
    # REST resources specific to employees at a given school
    class Employee < Kicksite::Schools::Person
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection

      ACTIVE_FILTER = 'active'.freeze

      CREATED_AT_SORT_BY = 'created_at'.freeze

      def photo!
        payload = KicksiteSvcBearerAuth.get("schools/#{prefix_options[:school_id]}/people/#{id}/photo")
        attributes['photo'] = payload.present? ? Person::Photo.new(payload, true) : nil

        attributes['photo']
      end

      def history!(options = {})
        payload = KicksiteSvcBearerAuth.get("schools/#{prefix_options[:school_id]}/people/#{id}/history", options)
        attributes['history'] =
          Kicksite::PaginatedCollection.new(payload.map do |event|
            Kicksite::Schools::Person::History.new(event, true)
          end)

        attributes['history']
      end
    end
  end
end
