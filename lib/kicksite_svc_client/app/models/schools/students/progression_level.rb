module Schools
  module Students
    # REST resources specific to Progression Levels (ranks) for given student
    class ProgressionLevel < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/students/:student_id/'
      self.collection_parser = PaginatedCollection

      def initialize(attributes = {}, persisted = false)
        if persisted
          APPOINTMENT_DATETIME_KEYS.each do |key|
            attributes[key] = to_datetime(attributes[key])
          end
        end

        super(attributes, persisted)
      end
    end
  end
end
