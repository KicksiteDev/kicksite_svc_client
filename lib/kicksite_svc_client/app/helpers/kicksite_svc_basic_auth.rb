require_relative 'kicksite_svc_base'

class KicksiteSvcBasicAuth < KicksiteSvcBase
  self.user = ENV['ADMIN_USER_NAME']
  self.password = ENV['ADMIN_PASSWORD']
end
