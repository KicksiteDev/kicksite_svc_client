require 'activeresource'
require 'activeresource-response'

# Our base that primarily just defines the kicksite-svc base url
class KicksiteSvcBase < ActiveResource::Base
  self.site = "#{ENV['KICKSITE_SVC_URL']}/v1"

  def initialize(attributes = {}, persisted = false)
    attributes['updated_at'] = to_datetime(attributes['updated_at'])
    attributes['created_at'] = to_datetime(attributes['created_at'])

    super(attributes, persisted)
  end

  protected

  def to_datetime(datetime_string)
    datetime_string.present? ? Time.parse(datetime_string) : datetime_string
  end
end
