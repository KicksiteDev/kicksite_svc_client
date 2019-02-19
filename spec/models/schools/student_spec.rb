RSpec.describe Schools::Student do
  let(:school_id) { 119 }

  it 'successfully returns all schools' do
    KicksiteSvcBearerAuth.connection.bearer_token = 'TOKEN'

    students = Schools::Student.find(:all, params: { page: 26, school_id: 119 })
    byebug
    p students.count
  end
end
