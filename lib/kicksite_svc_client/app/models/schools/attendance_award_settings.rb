module Kicksite
  module School
    # Accesses the attendance_award_settings off a school.
    # Not backed by any SvcObject, this is essentially just a nested hash on School
    # (using terrible text column serialization). We want to define getter methods
    # to define each of bronze/silver/gold, but the values of each of those should remain
    # a hash, so we can access each program IDs corresponding setting.
    class AttendanceAwardSettings
      attr_accessor :attendance_award_bronze, :attendance_award_silver, :attendance_award_gold
      def initialize(payload = {}, persisted = false)
        @attendance_award_bronze = payload['attendance_award_bronze']
        @attendance_award_silver = payload['attendance_award_silver']
        @attendance_award_gold = payload['attendance_award_gold']
      end
    end
  end
end

