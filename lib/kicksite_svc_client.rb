require 'kicksite_svc_client/version.rb'
require 'kicksite_svc_client/app/helpers/kicksite_svc_base.rb'
require 'kicksite_svc_client/app/helpers/kicksite_svc_bearer_auth.rb'
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/helpers/**/*.rb"].sort.each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/bizbuilder_forms/**/*.rb"]
  .sort.each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/families/**/*.rb"]
  .sort.each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/invoices/**/*.rb"]
  .sort.each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/memberships/**/*.rb"]
  .sort.each { |file| require file }
require 'kicksite_svc_client/app/models/schools/activity.rb'
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/people/**/*.rb"]
  .sort.each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/prospects/**/*.rb"]
  .sort.each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/students/**/*.rb"]
  .sort.each { |file| require file }
require 'kicksite_svc_client/app/models/schools/membership.rb'
require 'kicksite_svc_client/app/models/schools/person.rb'
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/schools/**/*.rb"].sort.each { |file| require file }
Dir["#{File.dirname(__FILE__)}/kicksite_svc_client/app/models/**/*.rb"].sort.each { |file| require file }

# Entry to REST api model definitions
module KicksiteSvcClient
  # NOTE: Anyone consuming this should mock the actual REST calls in their tests
  unless ENV['RAILS_ENV'] == 'test'
    raise 'Set KICKSITE_SVC_URL environment variable to utilize this gem' if ENV['KICKSITE_SVC_URL'].blank?
    raise 'Set ADMIN_USER_NAME environment variable to utilize this gem' if ENV['ADMIN_USER_NAME'].blank?
    raise 'Set ADMIN_PASSWORD environment variable to utilize this gem' if ENV['ADMIN_PASSWORD'].blank?
  end
end
