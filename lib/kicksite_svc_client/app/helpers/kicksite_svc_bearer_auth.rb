# Our base that requires basic authentication
class KicksiteSvcBearerAuth < KicksiteSvcBase
  connection.auth_type = :bearer

  self.collection_name = ''
  self.element_name = ''
end
