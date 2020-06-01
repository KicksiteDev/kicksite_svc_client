module Schools
  module Students
    # REST resources specific to Progression Levels (ranks) for given student
    class ProgressionLevel < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/students/:student_id/'
      self.collection_parser = PaginatedCollection

      def initialize(attributes = {}, persisted = false)
        super(attributes, persisted)
      end

      def image!(student_id) # kludge?
        KicksiteSvcBearerAuth.get(
          "schools/#{prefix_options[:school_id]}/students/#{student_id}/progression_levels/#{id}.image"
        )
      end
    end
  end
end
