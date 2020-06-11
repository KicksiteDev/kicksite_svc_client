RSpec.describe Person do
  let(:person_id) { 10_678 }

  it 'successfully returns a person' do
    person = Kicksite::Person.find(person_id)
    expect(person.id).to eq person_id
  end

  it 'successfully returns a photo' do
    person = Kicksite::Person.find(person_id)
    expect(person.photo).to_not be nil
  end
end
