module Kicksite
  module Schools
    # REST resources specific to tasks at a given school
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

