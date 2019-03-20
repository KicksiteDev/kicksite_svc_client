require_relative '../helpers/kicksite_svc_basic_auth'

class Person < KicksiteSvcBasicAuth
  class Photo < NoSvcObject; end

  def photo
    payload = get(:photo)
    Person::Photo.new(payload) if payload.present?
  end
end
