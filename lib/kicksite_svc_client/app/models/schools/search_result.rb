module Kicksite
  module Schools
    class SearchResult < Kicksite::NoSvcObject
      STUDENT_TYPE = 'Student'.freeze
      PROSPECT_TYPE = 'Prospect'.freeze
      FAMILY_TYPE = 'Family'.freeze
      INVOICE_TYPE = 'Invoice'.freeze
    end
  end
end
