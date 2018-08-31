require 'activeresource'

# Our base that primarily just defines the kicksite-svc base url
class KicksiteSvcBase < ActiveResource::Base
  self.site = "#{ENV['KICKSITE_SVC_URL']}/v1"
end
