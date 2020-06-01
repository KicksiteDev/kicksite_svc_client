module Schools
  module Students
    # REST resources specific to Progression Levels (ranks) for given student
    class ProgressionLevel < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/students/:student_id/'
      self.collection_parser = PaginatedCollection

      def initialize(attributes = {}, persisted = false)
        super(attributes, persisted)
      end

      def image_url # kludge?
        KicksiteSvcBase.site.to_s +
        "/schools/#{prefix_options[:school_id]}/students/#{prefix_options[:student_id]}/progression_levels/#{id}.image"
      end
    end
  end
end
