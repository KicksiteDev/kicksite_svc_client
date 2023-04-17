RSpec.describe Kicksite::Person do
  let(:person_id) { 10_678 }

  it 'successfully returns a person' do
    person = Kicksite::Person.find(person_id)
    expect(person.id).to eq person_id
  end
end
