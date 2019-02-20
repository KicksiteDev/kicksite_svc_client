RSpec.describe Schools::Student do
  let(:school_id) { 119 }

  it 'successfully returns paged students for a school' do
    KicksiteSvcBearerAuth.connection.bearer_token = 'TOKEN'
    students = School.find(119).students(params: { filter: Schools::Student::ACTIVE_FILTER })
    # students = Schools::Student.find(:all, params: { page: 1, school_id: 119 })
    p students.count
    p students.next_page
    p students.total_count
    students.first.school
  end
end
