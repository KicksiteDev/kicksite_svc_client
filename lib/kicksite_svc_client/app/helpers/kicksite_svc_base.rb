require 'activeresource'

class KicksiteSvcBase < ActiveResource::Base
  self.site = "#{ENV['KICKSITE_SVC_URL']}/v1"
end
