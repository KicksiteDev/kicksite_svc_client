require 'httparty'

RSpec.describe Schools::Membership do
  let(:school_id) { 119 }

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

  it 'successfully returns all memberships for school' do
    school = School.find(school_id)
    memberships = school.memberships
    expect(memberships).to_not be_empty
  end

  it 'successfully returns specific membership from within school' do
    school = School.find(school_id)
    memberships = school.memberships
    Schools::Membership.find(memberships.first.id, params: { school_id: school_id })
  end
end
