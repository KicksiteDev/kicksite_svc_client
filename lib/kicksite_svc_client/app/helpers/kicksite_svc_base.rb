require 'activeresource'
require 'activeresource-response'

# Our base that primarily just defines the kicksite-svc base url
class KicksiteSvcBase < ActiveResource::Base
  self.site = "#{ENV['KICKSITE_SVC_URL']}/v1"

  BASE_DATETIME_KEYS = %w[
    updated_at
    created_at
  ].freeze

  def initialize(attributes = {}, persisted = false)
    BASE_DATETIME_KEYS.each do |key|
      attributes[key] = to_datetime(attributes[key])
    end

    super(attributes, persisted)
  end

  protected

  def to_datetime(datetime_string)
    datetime_string.present? ? Time.parse(datetime_string) : datetime_string
  end
end
