require 'httparty'

RSpec.describe Kicksite::Schools::Prospects::Task do
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

  it 'successfully returns all tasks for prospect' do
    school = School.find(school_id)
    prospects = school.prospects
    tasks = prospects.first.tasks
    expect(tasks).to_not be_nil
  end
end
