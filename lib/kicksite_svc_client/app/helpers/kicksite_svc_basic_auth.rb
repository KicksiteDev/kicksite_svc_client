# Our base that requires basic authentication
class KicksiteSvcBasicAuth < KicksiteSvcBase
  self.user = ENV['ADMIN_USER_NAME']
  self.password = ENV['ADMIN_PASSWORD']

  self.collection_name = ''
  self.element_name = ''
end
