RSpec.describe School do
  let(:person_id) { 1 }

  it 'successfully returns a person' do
    person = Person.find(person_id)
    expect(person.id).to eq person_id
  end

  it 'successfully returns a photo' do
    person = Person.find(person_id)
    expect(person.photo).to_not be nil
  end
end