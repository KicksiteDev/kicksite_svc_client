# Our base that requires basic authentication
class KicksiteSvcBasicAuth < KicksiteSvcBase
  connection.auth_type = :bearer
  KicksiteSvcBearerAuth.connection.bearer_token =
    Base64.strict_encode64("#{ENV['ADMIN_USER_NAME']}:#{ENV['ADMIN_PASSWORD']}")

  self.collection_name = ''
  self.element_name = ''
end
