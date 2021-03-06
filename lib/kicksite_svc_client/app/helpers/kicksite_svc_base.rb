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
    if persisted
      BASE_DATETIME_KEYS.each do |key|
        attributes[key] = to_datetime(attributes[key])
      end
    end

    super(attributes, persisted)
  end

  def to_hash
    hash = {}
    attributes.each do |key, value|
      hash[key.to_s] = if value.present? && value.respond_to?(:to_hash)
                         value.to_hash
                       elsif value.present? && value.respond_to?(:attributes)
                         value.attributes
                       else
                         value
                       end
    end

    hash
  end

  protected

  def to_datetime(datetime_string)
    return datetime_string unless datetime_string.present?
    return datetime_string unless datetime_string.is_a?(String)

    Time.parse(datetime_string)
  end
end
