module Schools
  module People
    # REST resources specific to phone numbers associated with given person
    class PhoneNumber < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/people/:person_id/'

      def person
        Schools::Person.find(prefix_options[:person_id], params: { school_id: prefix_options[:school_id] })
      end
    end
  end
end
