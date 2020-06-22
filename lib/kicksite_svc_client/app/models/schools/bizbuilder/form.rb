module Kicksite
  module Schools
    module Bizbuilder
      # A lead capture form thing
      class Form < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/bizbuilder/'
        self.collection_parser = Kicksite::PaginatedCollection

        NAME_SORT_BY        = 'name'.freeze
        CREATED_AT_SORT_BY  = 'created_at'.freeze
        SUBMISSIONS_SORT_BY = 'submissions'.freeze
        ARCHIVED_FILTER     = 'archived'.freeze
        ACTIVE_FILTER       = 'active'.freeze

        # One of the field options for a lead capture form
        class FieldOption < Kicksite::NoSvcObject
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

        class Submission < Kicksite::NoSvcObject; end

        def submit(payload)
          post(:submissions, nil, { payload: payload }.to_json)
        end

        def submissions(options = {})
          payload = get(:submissions, options)
          Kicksite::PaginatedCollection.new(payload.map do |submission|
            Kicksite::Schools::Bizbuilder::Form::Submission.new(submission, true)
          end)
        end

        def self.field_options(options)
          payload = KicksiteSvcBearerAuth.get("schools/#{options[:school_id]}/bizbuilder/forms/fields")
          payload.map { |item| FieldOption.new(item, true) }
        end
      end
    end
  end
end
