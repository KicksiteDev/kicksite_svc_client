require 'httparty'

RSpec.describe Schools::Invoice do
  let(:school_id) { 119 }
  let(:invoice_id) { 8043 }

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

  it 'successfully returns specific invoice from within school' do
    school = School.find(school_id)
    Schools::Invoice.find(invoice_id, params: { school_id: school_id })
  end
end
