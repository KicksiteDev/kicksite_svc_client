Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/**/*.rb"].each {|file| require file }

module KicksiteSvcClient
  raise 'Set KICKSITE_SVC_URL environment variable to utilize this gem' if ENV['KICKSITE_SVC_URL'].blank?
  raise 'Set ADMIN_USER_NAME environment variable to utilize this gem' if ENV['ADMIN_USER_NAME'].blank?
  raise 'Set ADMIN_PASSWORD environment variable to utilize this gem' if ENV['ADMIN_PASSWORD'].blank?
end
