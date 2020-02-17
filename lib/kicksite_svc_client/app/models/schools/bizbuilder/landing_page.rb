module Schools
  module Bizbuilder
    # A lead capture form thing
    class LandingPage < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/bizbuilder/'
      self.collection_parser = PaginatedCollection

      class Submission < NoSvcObject; end

      def submit(payload)
        post(:submissions, nil, { payload: payload}.to_json)
      end

      def submissions(options = {})
        payload = get(:submissions, options)
        PaginatedCollection.new(payload.map do |submission|
                                  Schools::Bizbuilder::LandingPage::Submission.new(submission, true)
                                end)
      end
    end
  end
end
