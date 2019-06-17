RSpec.describe School do
  let(:school_id) { 119 }
  let(:school_subdomain) { 'trainingcenter' }

  it 'successfully returns a school by id' do
    school = School.find(school_id)
    expect(school.id).to eq school_id
    expect(school.subdomain).to_not be nil
  end

  it 'successfully returns a school by subdomain' do
    school = School.find(school_subdomain)
    expect(school.subdomain).to eq school_subdomain
    expect(school.id).to_not be nil
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
