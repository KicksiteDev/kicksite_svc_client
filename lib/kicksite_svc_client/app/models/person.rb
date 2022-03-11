module Kicksite
  # REST resources specific to People
  class Person < KicksiteSvcBasicAuth
    class Photo < Kicksite::NoSvcObject; end

    def photo
      return attributes['photo'] if attributes.key?('photo')

      photo!
    end

    def photo!
      payload = get(:photo)
      attributes['photo'] = payload.present? ? Kicksite::Person::Photo.new(payload, true) : nil

      attributes['photo']
    end

    def email_addresses(options = {})
      return attributes['email_addresses'] if options == {} && attributes.key?('email_addresses')

      email_addresses!(options)
    end

    def email_addresses!(options = {})
      opt = options.dup
      opt = { params: opt } if opt.keys.count != 1 && !opt.key?('params') && !opt.key?(:params)
      opt = opt.deep_merge(params: { school_id: prefix_options[:school_id], person_id: id })
      attributes['email_addresses'] = Kicksite::Schools::People::EmailAddress.find(:all, opt)

      attributes['email_addresses']
    end
  end
end
