# REST resources specific to People
class Person < KicksiteSvcBasicAuth
  class Photo < NoSvcObject; end

  def photo
    payload = get(:photo)
    Person::Photo.new(payload, true) if payload.present?
  end
end
