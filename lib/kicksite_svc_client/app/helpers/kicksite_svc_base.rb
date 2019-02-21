require 'activeresource'
require 'activeresource-response'

# Our base that primarily just defines the kicksite-svc base url
class KicksiteSvcBase < ActiveResource::Base
  self.site = "#{ENV['KICKSITE_SVC_URL']}/v1"

  def initialize(attributes = {}, persisted = false)
    attributes['updated_at'] = to_datetime(attributes['updated_at']) if attributes['updated_at'].present?
    attributes['created_at'] = to_datetime(attributes['created_at']) if attributes['created_at'].present?

    super(attributes, persisted)
  end

  protected

  def to_datetime(datetime_string)
    Time.parse(datetime_string)
  end
end
