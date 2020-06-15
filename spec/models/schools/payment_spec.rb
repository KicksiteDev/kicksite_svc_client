require 'httparty'

RSpec.describe Kicksite::Schools::Payment do
  let(:school_id) { 119 }
  let(:payment_id) { 16_996 }

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

  it 'successfully returns specific payment from within school' do
    Kicksite::Schools::Payment.find(payment_id, params: { school_id: school_id })
  end
end
