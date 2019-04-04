require 'httparty'

RSpec.describe Schools::Family do
  let(:school_id) { 119 }
  let(:family_id) { 52701 }

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

    new_user_session_url = "#{ENV['KICKSITE_SVC_URL']}/v1/users/new/sessions"
    token = HTTParty.post(new_user_session_url, options)['token']
    KicksiteSvcBearerAuth.connection.bearer_token = token
  end

  it 'successfully returns specific family from within school' do
    school = School.find(school_id)
    Schools::Family.find(family_id, params: { school_id: school_id })
  end
end