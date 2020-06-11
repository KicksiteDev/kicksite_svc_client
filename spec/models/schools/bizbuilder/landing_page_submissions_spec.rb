require 'httparty'

RSpec.describe Kicksite::Schools::Bizbuilder::LandingPage do
  let(:school_id) { 119 }
  let(:landing_page_id) { 1 }

  before do
    options = {
      body: {
        login: ENV['ADMIN_USER_NAME'],
        password: ENV['ADMIN_PASSWORD'],
        context: {
          type: 'School',
          id: school_id
        }
      }
    }

    new_user_session_url = "#{ENV['KICKSITE_AUTH_URL']}/v1/users/new/sessions"
    token = HTTParty.post(new_user_session_url, options)['token']
    KicksiteSvcBearerAuth.connection.bearer_token = token
  end

  it 'successfully returns all landing page submissions for a landing page' do
    landing_page = Kicksite::Schools::Bizbuilder::LandingPage.find(landing_page_id, params: { school_id: school_id })
    landing_page.submissions(school_id: school_id, landing_page_id: landing_page_id)
  end
end
