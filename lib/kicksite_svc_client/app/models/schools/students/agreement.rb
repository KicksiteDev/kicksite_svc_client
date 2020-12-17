module Kicksite
  module Schools
    module Students
      # REST resources specific to Agreements associated with given Student
      class Agreement < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/students/:student_id/'
        self.collection_parser = Kicksite::PaginatedCollection

        ACTIVE_FILTER = 'active'.freeze

        CREATED_AT_SORT_BY  = 'created_at'.freeze
        DATE_SIGNED_SORT_BY = 'date_signed'.freeze
        NAME_SORT_BY        = 'name'.freeze
        STATUS_SORT_BY      = 'status'.freeze

        class Preview < Kicksite::NoSvcObject; end

        def preview(options = {})
          KicksiteSvcBearerAuth.get(
            "schools/#{prefix_options[:school_id]}/prospects/" \
            "#{options[:prospect_id]}/agreements/#{options[:id]}/preview"
          )
        end
      end
    end
  end
end
