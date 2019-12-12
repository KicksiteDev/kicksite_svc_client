module Schools
  module Bizbuilder
    # A lead capture form thing
    class Form < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/bizbuilder/'
      self.collection_parser = PaginatedCollection

      NAME_SORT_BY        = 'name'.freeze
      CREATED_AT_SORT_BY  = 'created_at'.freeze
      SUBMISSIONS_SORT_BY = 'submissions'.freeze

      # One of the field options for a lead capture form
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
          KicksiteSvcBearerAuth.post(url, nil, to_hash.to_json)
        end
      end

      class Submission < NoSvcObject; end

      ARCHIVED_FILTER = 'archived'.freeze
      ACTIVE_FILTER = 'active'.freeze
      CREATED_AT_SORT_BY = 'created_at'.freeze

      def submit(payload)
        post(:submissions, payload: payload)
      end

      def submissions(options = {})
        payload = get(:submissions, options)
        PaginatedCollection.new(payload.map do |submission|
          Schools::Bizbuilder::Form::Submission.new(submission, true)
        end)
      end

      def self.field_options(options)
        payload = KicksiteSvcBearerAuth.get("schools/#{options[:school_id]}/bizbuilder/forms/fields")
        payload.map { |item| FieldOption.new(item, true) }
      end
    end
  end
end
