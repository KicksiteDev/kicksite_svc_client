module Kicksite
  module Schools
    module Students
      module Constants
        NEW_FILTER = 'new'.freeze
        ACTIVE_FILTER = 'active'.freeze
        ACTIVE_WITHOUT_FROZEN = 'active_without_frozen'.freeze
        LOST_FILTER = 'lost'.freeze
        INACTIVE_FILTER = 'inactive'.freeze
        FROZEN_FILTER = 'frozen'.freeze
        ABSENT_FILTER = 'absent'.freeze
        HAS_BIRTHDAY_FILTER = 'has_birthday'.freeze
        HAS_BIRTHDAY_AND_IS_ACTIVE_FILTER = 'has_birthday_and_is_active'.freeze

        CREATED_AT_SORT_BY = 'created_at'.freeze
        BIRTHDATE_SORT_BY = 'birthdate'.freeze
        NEXT_BIRTHDAY_SORT_BY = 'next_birthday'.freeze
      end
    end
  end
end
