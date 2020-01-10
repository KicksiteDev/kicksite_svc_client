module Schools
  # Concept around immediate and scheduled communication based on various triggered events
  class MessageFlow < KicksiteSvcBearerAuth
    self.prefix = '/v1/schools/:school_id/'
    self.collection_parser = PaginatedCollection

    PROSPECT_AUDIENCE = 'prospect'.freeze
    STUDENT_AUDIENCE = 'student'.freeze

    ACTIVE_STATUS = 'active'.freeze
    ARCHIVED_STATUS = 'archived'.freeze

    CREATED_AT_TRIGGER = 'created_at'.freeze
    CONVERTED_ON_TRIGGER = 'converted_on'.freeze
    ATTENDANCES_TRIGGER = 'attendances'.freeze
    BIRTHDAY_TRIGGER = 'birthday'.freeze
  end
end
