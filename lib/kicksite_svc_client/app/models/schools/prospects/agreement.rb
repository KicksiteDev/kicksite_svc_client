module Kicksite
  module Schools
    module Prospects
      # REST resources specific to Agreements associated with given Prospect
      class Agreement < KicksiteSvcBearerAuth
        self.prefix = '/v1/schools/:school_id/prospects/:prospect_id/'
        self.collection_parser = Kicksite::PaginatedCollection

        CREATED_AT_SORT_BY  = 'created_at'.freeze
        DATE_SIGNED_SORT_BY = 'date_signed'.freeze
        NAME_SORT_BY        = 'name'.freeze
        STATUS_SORT_BY      = 'status'.freeze
      end
    end
  end
end
