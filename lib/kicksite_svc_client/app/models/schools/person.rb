module Kicksite
  module Schools
    # REST resources specific to People at a given school
    class Person < KicksiteSvcBearerAuth
      self.prefix = '/v1/schools/:school_id/'
      self.collection_parser = Kicksite::PaginatedCollection

      class Photo < Kicksite::NoSvcObject; end
      class History < Kicksite::Schools::Activity; end

      PERSON_DATETIME_KEYS = %w[
        inactivated_on
        converted_to_prospect_on
        converted_to_student_on
        frozen_on
        unfreeze_on
        birthdate
        next_birthday
      ].freeze

      def initialize(attributes = {}, persisted = false)
        if persisted
          PERSON_DATETIME_KEYS.each do |key|
            attributes[key] = to_datetime(attributes[key])
          end
        end

        super(attributes, persisted)
      end

      def photo
        return attributes['photo'] if attributes.key?('photo')

        photo!
      end

      def photo!
        payload = get(:photo)
        attributes['photo'] = payload.present? ? Person::Photo.new(payload, true) : nil

        attributes['photo']
      end

      def phone_numbers(options = {})
        return attributes['phone_numbers'] if options == {} && attributes.key?('phone_numbers')

        phone_numbers!(options)
      end

      def phone_numbers!(options = {})
        opt = options.dup
        opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id], person_id: id })
        attributes['phone_numbers'] = Kicksite::Schools::People::PhoneNumber.find(:all, opt)

        attributes['phone_numbers']
      end

      def email_addresses(options = {})
        return attributes['email_addresses'] if options == {} && attributes.key?('email_addresses')

        email_addresses!(options)
      end

      def email_addresses!(options = {})
        opt = options.dup
        opt = opt.keys.count == 1 && (opt.key?('params') || opt.key?(:params)) ? opt : { params: opt }
        opt = opt.deep_merge(params: { school_id: prefix_options[:school_id], person_id: id })
        attributes['email_addresses'] = Kicksite::Schools::People::EmailAddress.find(:all, opt)

        attributes['email_addresses']
      end

      def history(options = {})
        return attributes['history'] if options == {} && attributes.key?('history')

        history!(options)
      end

      def history!(options = {})
        payload = get(:history, options)
        attributes['history'] =
          Kicksite::PaginatedCollection.new(payload.map do |event|
            Kicksite::Schools::Person::History.new(event, true)
          end)

        attributes['history']
      end
    end
  end
end
