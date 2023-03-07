# location: spec/unit/unit_spec.rb
require 'rails_helper'

RSpec.describe(User, type: :model) do
  subject do
    described_class.new(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1')
  end

  it 'User is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'User is not valid without a first name' do
    subject.first_name = nil
    expect(subject).not_to(be_valid)
  end

  it 'User is not valid without a last name' do
    subject.last_name = nil
    expect(subject).not_to(be_valid)
  end

  it 'User is not valid without a uin' do
    subject.uin = nil
    expect(subject).not_to(be_valid)
  end

  it 'User is not valid without an email' do
    subject.email = nil
    expect(subject).not_to(be_valid)
  end

  it 'User is not valid without a dob' do
    subject.dob = nil
    expect(subject).not_to(be_valid)
  end
end

RSpec.describe(UserEvent, type: :model) do
  subject do
    described_class.new(user: user, event: event)
  end

  let(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  let(:event) { Event.create(start: '2022-10-10', end: '2023-10-10', type_id: '3', status: 'ongoing') }

  it 'userevent is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'userevent is not valid without a user id' do
    subject.user_id = nil
    expect(subject).not_to(be_valid)
  end

  it 'userevent is not valid without a event id' do
    subject.event_id = nil
    expect(subject).not_to(be_valid)
  end
end

RSpec.describe(Event, type: :model) do
  subject do
    described_class.new(start: '2022-10-10', end: '2023-10-10', type_id: '3', status: 'ongoing')
  end

  it 'event is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'event is not valid without a start date' do
    subject.start = nil
    expect(subject).not_to(be_valid)
  end

  it 'event is not valid without an end date' do
    subject.end = nil
    expect(subject).not_to(be_valid)
  end

  it 'event is not valid without a type id' do
    subject.type_id = nil
    expect(subject).not_to(be_valid)
  end

  it 'event is not valid without a status' do
    subject.status = nil
    expect(subject).not_to(be_valid)
  end
end

RSpec.describe(EventType, type: :model) do
  subject do
    described_class.new(points: '2')
  end

  it 'eventtype is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'eventtype is not valid without points value' do
    subject.points = nil
    expect(subject).not_to(be_valid)
  end
end

RSpec.describe(EventType, type: :model) do
  subject do
    described_class.new(points: '2')
  end

  it 'eventtype is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'eventtype is not valid without points value' do
    subject.points = nil
    expect(subject).not_to(be_valid)
  end
end
