require 'httparty'

RSpec.describe Kicksite::Schools::Person do
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

  it 'successfully returns all people for school' do
    school = School.find(school_id)
    people = school.people
    expect(people).to_not be_empty
  end

  it 'successfully returns a specific person within school' do
    school = School.find(school_id)
    people = school.people
    Kicksite::Schools::Person.find(people.first.id, params: { school_id: school_id })
  end

  it 'successfully returns phone numbers for a specific person' do
    school = School.find(school_id)
    people = school.people
    people.first.phone_numbers
  end
end
