Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/**/*.rb"].each { |file| require file }

# Entry to REST api model definitions
module KicksiteSvcClient
  # Note: Anyone consuming this should mock the actual REST calls in their tests
  unless ENV['RAILS_ENV'] == 'test'
    raise 'Set KICKSITE_SVC_URL environment variable to utilize this gem' if ENV['KICKSITE_SVC_URL'].blank?
    raise 'Set ADMIN_USER_NAME environment variable to utilize this gem' if ENV['ADMIN_USER_NAME'].blank?
    raise 'Set ADMIN_PASSWORD environment variable to utilize this gem' if ENV['ADMIN_PASSWORD'].blank?
  end
end
