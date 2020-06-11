module Kicksite
  module Schools
    module Bizbuilder
      # A lead capture form thing
      class LandingPage < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/bizbuilder/'
        self.collection_parser = Kicksite::PaginatedCollection

        NAME_SORT_BY        = 'name'.freeze
        CREATED_AT_SORT_BY  = 'created_at'.freeze
        SUBMISSIONS_SORT_BY = 'submissions'.freeze
        ARCHIVED_FILTER     = 'archived'.freeze
        ACTIVE_FILTER       = 'active'.freeze

        class Submission < Kicksite::NoSvcObject; end

        def submit(payload)
          post(:submissions, nil, { payload: payload }.to_json)
        end

        def submissions(options = {})
          payload = get(:submissions, options)
          Kicksite::PaginatedCollection.new(payload.map do |submission|
                                    Kicksite::Schools::Bizbuilder::LandingPage::Submission.new(submission, true)
                                  end)
        end
      end
    end
  end
end
