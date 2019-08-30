require 'kicksite_svc_client/version.rb'
require 'kicksite_svc_client/app/helpers/kicksite_svc_base.rb'
require 'kicksite_svc_client/app/helpers/kicksite_svc_bearer_auth.rb'
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/helpers/**/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/association_memberships/**/*.rb"]
  .each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/bizbuilder_forms/**/*.rb"]
  .each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/families/**/*.rb"]
  .each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/invoices/**/*.rb"]
  .each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/memberships/**/*.rb"]
  .each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/people/**/*.rb"]
  .each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/prospects/**/*.rb"]
  .each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/students/**/*.rb"]
  .each { |file| require file }
require 'kicksite_svc_client/app/models/schools/person.rb'
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/**/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/**/*.rb"].each { |file| require file }

# Entry to REST api model definitions
module KicksiteSvcClient
  # Note: Anyone consuming this should mock the actual REST calls in their tests
  unless ENV['RAILS_ENV'] == 'test'
    raise 'Set KICKSITE_SVC_URL environment variable to utilize this gem' if ENV['KICKSITE_SVC_URL'].blank?
    raise 'Set ADMIN_USER_NAME environment variable to utilize this gem' if ENV['ADMIN_USER_NAME'].blank?
    raise 'Set ADMIN_PASSWORD environment variable to utilize this gem' if ENV['ADMIN_PASSWORD'].blank?
  end
end
