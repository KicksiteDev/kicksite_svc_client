RSpec.describe Schools::Student do
  let(:school_id) { 119 }

  it 'successfully returns all schools' do
    # KicksiteSvcBearerAuth.connection.auth_type = :bearer
    # KicksiteSvcBearerAuth.connection.bearer_token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NTAwODg2NDksInN1YiI6NDgyN30.Se5luLorQtvtozuItADG54oCNefrOTbQBRE2XiIhE0E'

    students = Schools::Student.find(:all, :params => {:school_id => 119})
    p students.count
  end
end
