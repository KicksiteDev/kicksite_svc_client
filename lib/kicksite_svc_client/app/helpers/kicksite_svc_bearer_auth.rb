require_relative 'kicksite_svc_base'

# Our base that requires basic authentication
class KicksiteSvcBearerAuth < KicksiteSvcBase
  self.connection.auth_type = :bearer
end
