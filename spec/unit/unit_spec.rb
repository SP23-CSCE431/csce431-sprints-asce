# location: spec/unit/unit_spec.rb
require 'rails_helper'

RSpec.describe(User, type: :model) do
  let(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
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

  it 'User is not valid with integer email' do
    subject.email = 1
    expect(subject).not_to(be_valid)
  end

  it 'User is not valid for duplicate email' do
    subject.save!
    expect {
    described_class.create!
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'User is not valid with non 9-digit uin' do
    subject.uin = 'alsdkfjalsdfk'
    expect(subject).not_to(be_valid)
    subject.uin = '1234567'
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

  it 'userevent is not valid when user id is nil' do
    subject.user_id = nil
    expect(subject).not_to(be_valid)
  end

  it 'userevent is not valid when event id is nil' do
    subject.event_id = nil
    expect(subject).not_to(be_valid)
  end

  it 'userevent is not valid when user id is string' do
    subject.user_id = 'one'
    expect(subject).not_to(be_valid)
  end

  it 'userevent is not valid when event id is string' do
    subject.event_id = 'two'
    expect(subject).not_to(be_valid)
  end

  it 'userevent is not valid when user id is double' do
    subject.user_id = 1.0
    expect(subject).not_to(be_valid)
  end

  it 'userevent is not valid when event id is double' do
    subject.event_id = 2.0
    expect(subject).not_to(be_valid)
  end

  it 'raises error when creating duplicate user_event' do
    subject.save!
    expect {
    described_class.create!(user: user, event: event)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
end

RSpec.describe(Event, type: :model) do
  subject do
    described_class.new(start: '2022-10-10', end: '2023-10-10', type_id: '3', status: 'ongoing', name: 'ten', description: 'add points', points: '10')
  end

  it 'event is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'event is not valid without a start date' do
    subject.start = nil
    expect(subject).not_to(be_valid)
  end

  it 'event is not valid for invalid start date' do
    subject.start = 12345
    expect(subject).not_to(be_valid)
  end

  it 'event is not valid for invalid end date' do
    subject.end = 12345
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
