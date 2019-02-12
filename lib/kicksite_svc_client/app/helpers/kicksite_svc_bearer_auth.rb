require_relative 'kicksite_svc_base'

# Our base that requires basic authentication
class KicksiteSvcBearerAuth < KicksiteSvcBase
  self.connection.auth_type = :bearer
  self.connection.bearer_token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NTAwODg2NDksInN1YiI6NDgyN30.Se5luLorQtvtozuItADG54oCNefrOTbQBRE2XiIhE0E'
end
