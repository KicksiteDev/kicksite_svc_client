# REST resources specific to People
class Person < KicksiteSvcBasicAuth
  class Photo < NoSvcObject; end

  def photo
    return attributes['photo'] if attributes.key?('photo')

    photo!
  end

  def photo!
    payload = get(:photo)
    attributes['photo'] = if payload.present?
                            Person::Photo.new(payload, true)
                          else
                            nil
                          end

    attributes['photo']
  end
end
