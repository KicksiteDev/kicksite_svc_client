RSpec.describe School do
  let(:school_id) { 119 }
  let(:school_subdomain) { 'trainingcenter' }

  it 'successfully returns all schools' do
    schools = School.all(params: { subdomain: school_subdomain })
    expect(schools).to_not be_empty
  end

  it 'successfully returns a school' do
    school = School.find(school_id)
    expect(school.id).to eq school_id
    expect(school.subdomain).to_not be nil
  end

  it 'successfully returns a merchant account' do
    school = School.find(school_id)
    expect(school.merchant_account).to_not be nil
  end

  it 'successfully returns a logo' do
    school = School.find(school_id)
    expect(school.logo).to_not be nil
  end
end
