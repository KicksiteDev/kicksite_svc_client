module Kicksite
  # REST resources specific to People
  class Person < KicksiteSvcBasicAuth
    class Photo < Kicksite::NoSvcObject; end
    class Preferences < Kicksite::NoSvcObject; end

    def photo
      return attributes['photo'] if attributes.key?('photo')

      photo!
    end

    def photo!
      payload = get(:photo)
      attributes['photo'] = payload.present? ? Kicksite::Person::Photo.new(payload, true) : nil

      attributes['photo']
    end
  end
end
