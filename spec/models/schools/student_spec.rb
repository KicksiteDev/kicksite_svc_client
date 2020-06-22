require 'httparty'

RSpec.describe Kicksite::Schools::Student do
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

  it 'successfully returns all students for school' do
    school = Kicksite::School.find(school_id)
    students = school.students
    expect(students).to_not be_empty
  end

  it 'successfully returns a specific student within school' do
    school = Kicksite::School.find(school_id)
    students = school.students
    Kicksite::Schools::Student.find(students.first.id, params: { school_id: school_id })
  end

  it 'successfully returns phone numbers for a specific student' do
    school = Kicksite::School.find(school_id)
    students = school.students
    students.first.phone_numbers
  end
end
