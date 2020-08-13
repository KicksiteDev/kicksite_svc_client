module Kicksite
  # REST resources specific to Schools
  class Gender
    VALID_GENDERS = [ # The rest of y'all are also valid, hope we get to fix this someday
      'Prefer not to say',
      'Male',
      'Female'
    ].freeze

    def all
      VALID_GENDERS
    end
  end
end
