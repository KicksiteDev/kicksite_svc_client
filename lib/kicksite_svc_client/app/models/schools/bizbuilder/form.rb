module Schools
  module Bizbuilder
    class Form < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/bizbuilder/'
      self.collection_parser = PaginatedCollection

      class FieldOption < NoSvcObject
        def save
          save!
          true
        rescue StandardError
          false
        end

        def save!
          context_type = 'School' if context_type.blank?
          raise "Invalid context: #{context_type}" unless context_type == 'School'

          url = "schools/#{context_id}/bizbuilder/forms/fields"
          @persisted ? KicksiteSvcBearerAuth.put(url, nil, self.to_hash.to_json) : KicksiteSvcBearerAuth.post(url, nil, self.to_hash.to_json)
        end
      end

      ARCHIVED_FILTER = 'archived'.freeze
      ACTIVE_FILTER = 'active'.freeze

      def submit(payload)
        post(:submissions, payload: payload)
      end

      def submissions
        get(:submissions)
      end

      def self.field_options(options)
        payload = KicksiteSvcBearerAuth.get("schools/#{options[:school_id]}/bizbuilder/forms/fields")
        payload.map { |item| FieldOption.new(item, true) }
      end
    end
  end
end
