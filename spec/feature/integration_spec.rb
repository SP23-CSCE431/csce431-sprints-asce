# location: spec/feature/integration_spec.rb
require 'rails_helper'


RSpec.describe('Authentication Test', type: :feature) do
  it 'valid authentication' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to(have_content('You\'re logged in!'))
  end
end

RSpec.describe('Navigation Test', type: :feature) do
  let!(:user) { User.create(first_name: 'John', last_name: 'Doe', uin: '730303036', phone_number: '8324344445', email: 'johndoe@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  let!(:event) { Event.create(start: '2022-10-10', end: '2023-10-10', type_id: '3', status: 'ongoing', name: 'Event 1', description: 'This is Event 1') }
  let!(:user_event) { UserEvent.create(user_id: user.id, event_id: event.id) }
  it 'has navigation on every page' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to(have_content('Home Page'))
    visit profile_path
    expect(page).to(have_content('Home Page'))
    visit edit_user_path(user)
    expect(page).to(have_content('Home Page'))
    visit help_user_path(id: user.id)
    expect(page).to(have_content('Home Page'))
    visit users_path
    expect(page).to(have_content('Home Page'))
    visit new_user_path
    expect(page).to(have_content('Home Page'))
    visit user_path(user)
    expect(page).to(have_content('Home Page'))
    visit calendar_path
    expect(page).to(have_content('Home Page'))
    visit edit_user_event_path(user_event)
    expect(page).to(have_content('Home Page'))
    visit user_events_path
    expect(page).to(have_content('Home Page'))
    visit my_events_path
    expect(page).to(have_content('Home Page'))
    visit new_user_event_path
    expect(page).to(have_content('Home Page'))
    visit user_event_path(user_event)
    expect(page).to(have_content('Home Page'))
    visit edit_event_path(event)
    expect(page).to(have_content('Home Page'))
    visit events_path
    expect(page).to(have_content('Home Page'))
    visit new_event_path
    expect(page).to(have_content('Home Page'))
    visit event_path(event)
    expect(page).to(have_content('Home Page'))
    visit pages_event_sign_in_path
    expect(page).to(have_content('Home Page'))
    visit pages_reset_user_points_path
    expect(page).to(have_content('Home Page'))
  end
end

RSpec.describe('Creating a user', type: :feature) do
  let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student2@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  it 'valid inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_path
    fill_in 'user[first_name]', with: 'harry'
    fill_in 'user[last_name]', with: 'potter'
    fill_in 'user[uin]', with: '730303030'
    fill_in 'user[email]', with: 'student@tamu.edu'
    fill_in 'user[phone_number]', with: '1234567898'
    fill_in 'user[dob]', with: '2003-10-10'
    click_on 'Save'
    expect(page).to(have_content('User was successfully created'))
  end

  it 'blank inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_path
    click_on 'Save'
    expect(page).to(have_content('prohibited this user from being saved:'))
  end

  it 'invalid uin' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_path
    fill_in 'user[first_name]', with: 'harry'
    fill_in 'user[last_name]', with: 'potter'
    fill_in 'user[uin]', with: 'abcdefg'
    fill_in 'user[email]', with: 'student@tamu.edu'
    fill_in 'user[phone_number]', with: '1234567898'
    fill_in 'user[dob]', with: '2003-10-10'
    click_on 'Save'
    expect(page).to(have_content('prohibited this user from being saved:'))
  end

  it 'invalid email' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_path
    fill_in 'user[first_name]', with: 'harry'
    fill_in 'user[last_name]', with: 'potter'
    fill_in 'user[uin]', with: 'abcdefg'
    fill_in 'user[email]', with: 'student@gmail.com'
    fill_in 'user[phone_number]', with: '1234567898'
    fill_in 'user[dob]', with: '2003-10-10'
    click_on 'Save'
    expect(page).to(have_content('prohibited this user from being saved:'))
  end

  it 'duplicate email' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_path
    fill_in 'user[first_name]', with: 'harry'
    fill_in 'user[last_name]', with: 'potter'
    fill_in 'user[uin]', with: 'abcdefg'
    fill_in 'user[email]', with: 'student2@tamu.edu'
    fill_in 'user[phone_number]', with: '1234567898'
    fill_in 'user[dob]', with: '2003-10-10'
    click_on 'Save'
    expect(page).to(have_content('prohibited this user from being saved:'))
  end
end

RSpec.describe('Viewing Profile', type: :feature) do
  let!(:user) { User.create(first_name: 'John', last_name: 'Doe', uin: '730303036', phone_number: '8324344445', email: 'johndoe@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  let!(:user2) { User.create(first_name: 'Jill', last_name: 'Doe', uin: '730303436', phone_number: '8324344445', email: 'jilldoe@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  it 'Shows current user information' do
    visit '/admins/auth/google_oauth2/callback'
    visit profile_path
    expect(page).to(have_content('johndoe@tamu.edu'))
  end
  it 'Does not show other user information' do
    visit '/admins/auth/google_oauth2/callback'
    visit profile_path
    expect(page).not_to(have_content('jilldoe@tamu.edu'))
  end
end

RSpec.describe('Editing a user', type: :feature) do
  let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  let!(:user2) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student2@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  it 'valid edit' do
    visit '/admins/auth/google_oauth2/callback'
    visit edit_user_path(user)
    fill_in 'user[first_name]', with: 'bob'
    click_on 'Save'
    user.reload
    expect(user.first_name).to eq('bob')
  end
  it 'invalid email' do
    visit '/admins/auth/google_oauth2/callback'
    visit edit_user_path(user)
    fill_in 'user[email]', with: 'student2@tamu.edu'
    click_on 'Save'
    expect(page).to(have_content('prohibited'))
  end
  it 'blank input' do
    visit '/admins/auth/google_oauth2/callback'
    visit edit_user_path(user)
    fill_in 'user[first_name]', with: ''
    click_on 'Save'
    expect(page).to(have_content('prohibited'))
  end
end

RSpec.describe('Deleting a user', type: :feature) do
  let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  let!(:current_user) { User.create(first_name: 'John', last_name: 'Doe', uin: '730303036', phone_number: '8324344445', email: 'johndoe@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  it 'valid deletion' do
    visit '/admins/auth/google_oauth2/callback'
    visit user_path(user)
    click_on 'Delete'
    expect(page).to(have_content('Successfully'))
  end

  it 'Deleting the current user' do
    visit '/admins/auth/google_oauth2/callback'
    visit user_path(current_user)
    click_on 'Delete'
    expect(page).to(have_content('You\'re Logged out!'))
  end
end

RSpec.describe('Member Signing Up for an Event', type: :feature) do
  let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  let!(:event) { Event.create(start: '2022-10-10', end: '2023-10-10', type_id: '3', status: 'ongoing', name: 'Event 1', description: 'This is Event 1') }
  it 'valid inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_event_path
    fill_in 'user_event[user_id]', with: user.id
    fill_in 'user_event[event_id]', with: event.id
    click_on 'Add Event'
    visit user_events_path
    expect(page).to(have_content(event.name))
  end

  it 'blank inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_event_path
    click_on 'Add Event'
    expect(page).to(have_content('errors prohibited this user_event from being saved'))
  end

  it 'invalid event' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_event_path
    fill_in 'user_event[user_id]', with: user.id
    fill_in 'user_event[event_id]', with: ' '
    click_on 'Add Event'
    expect(page).to(have_content('Event must exist'))
  end
end

RSpec.describe('Updating a UserEvent', type: :feature) do
  let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  let!(:event1) { Event.create(start: '2022-10-10', end: '2023-10-10', type_id: '3', status: 'ongoing', name: 'Event 1', description: 'This is Event 1') }
  let!(:event2) { Event.create(start: '2022-11-10', end: '2023-11-10', type_id: '3', status: 'ongoing', name: 'Event 2', description: 'This is Event 2') }
  let!(:user_event) { UserEvent.create(user_id: user.id, event_id: event1.id) }

  it 'valid update' do
    visit '/admins/auth/google_oauth2/callback'
    visit edit_user_event_path(user_event)
    fill_in 'user_event[user_id]', with: user.id
    fill_in 'user_event[event_id]', with: event2.id
    click_on 'Add Event'
    visit user_events_path
    expect(page).to(have_content(event2.name))
  end

  it 'invalid update due to nonexistent event' do
    visit '/admins/auth/google_oauth2/callback'
    visit edit_user_event_path(user_event)
    fill_in 'user_event[user_id]', with: user.id
    fill_in 'user_event[event_id]', with: '20'
    click_on 'Add Event'
    expect(page).to(have_content('Event must exist'))
  end
end

RSpec.describe('My Personal Calendar:', type: :feature) do
  let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  let!(:event1) { Event.create(start: Date.current, end: Date.current + 1.days, type_id: '3', status: 'ongoing', name: 'Event 1', description: 'This is Event 1') }
  let!(:event2) { Event.create(start: '2022-11-10', end: '2022-12-10', type_id: '3', status: 'ongoing', name: 'Event 2', description: 'This is Event 2') }

  it 'valid event added to calendar' do
    visit '/admins/auth/google_oauth2/callback'
    visit calendar_path(user_id: user.id)
    expect(page).not_to(have_content(event1.start.strftime('%Y-%m-%d')))
    visit new_user_event_path
    fill_in 'user_event[user_id]', with: user.id
    fill_in 'user_event[event_id]', with: event1.id
    click_on 'Add Event'
    visit calendar_path(user_id: user.id)
    expect(page).to(have_content(event1.start.strftime('%Y-%m-%d')))
  end

  it 'newly registered user should have empty calendar' do
    visit '/admins/auth/google_oauth2/callback'
    visit calendar_path(user_id: user.id)
    expect(page).not_to(have_content(event1.start.strftime('%Y-%m-%d')))
  end

  it 'user adds event and it automatically appears on calendar' do
    visit '/admins/auth/google_oauth2/callback'
    visit calendar_path(user_id: user.id)
    expect(page).not_to(have_content(event1.start.strftime('%Y-%m-%d')))
    visit new_user_event_path
    fill_in 'user_event[user_id]', with: user.id
    fill_in 'user_event[event_id]', with: event1.id
    click_on 'Add Event'
    visit calendar_path(user_id: user.id)
    expect(page).to(have_content(event1.start.strftime('%Y-%m-%d')))
  end

  it 'user tries to add an event that has already occurred' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_event_path
    fill_in 'user_event[user_id]', with: user.id
    fill_in 'user_event[event_id]', with: event2.id
    click_on 'Add Event'
    visit calendar_path(user_id: user.id)
    expect(page).not_to(have_content(event2.start.strftime('%Y-%m-%d')))
  end
end

RSpec.describe "User Search and Table Display", type: :feature do
  before do
  # create some users for testing
    User.create(first_name: 'John', last_name: 'Doe', uin: '123456789', phone_number: '555-123-4567', email: 'john@example.com', dob: '1990-01-01', points: '10', role_id: '1')
    User.create(first_name: 'Jane', last_name: 'Smith', uin: '987654321', phone_number: '555-987-6543', email: 'jane@example.com', dob: '1995-05-05', points: '20', role_id: '2')
    User.create(first_name: 'Bob', last_name: 'Hanks', uin: '456789123', phone_number: '555-456-7890', email: 'bob@example.com', dob: '1985-10-10', points: '5', role_id: '1')
  end
  
  context "when search for a user with first name 'John'" do
    it "displays only the user with first name 'John'" do
      visit '/admins/auth/google_oauth2/callback'
      visit users_path     
      fill_in 'q[first_name_or_last_name_or_uin_cont]', with: 'John'
      click_button 'Search!'
      
      expect(page).to_not have_content('Jane')
      expect(page).to_not have_content('Bob')
    end
  end
end

RSpec.describe('Main Calendar:', type: :feature) do
  let!(:event1) { Event.create(start: '2022-11-10', end: '2022-12-10', type_id: '3', status: 'ongoing', name: 'Test Event 1', description: 'This is Test Event 1', points: 3) }
  let!(:event2) { Event.create(start: '2022-11-10', end: '2022-12-10', type_id: '3', status: 'ongoing', name: 'Test Event 2', description: 'This is Test Event 2', points: 2) }
  let!(:event3) { Event.create(start: '2023-03-31 10:00:00', end: '2023-03-31 11:00:00', name: 'Test Event 1', description: 'This is Test Event 1', points: 3) }
  let!(:event4) { Event.create(start: '2023-03-31 10:00:00', end: '2023-03-31 11:00:00', name: 'Test Event 2', description: 'This is Test Event 2', points: 2) }

  it 'should automatically show the view based on the current month and year' do
    visit '/admins/auth/google_oauth2/callback'
    visit root_path
    expect(page).to have_content(Date.current.strftime('%B %Y'))
  end

  it 'should display the next month accordingly when the next button is clicked' do
    visit '/admins/auth/google_oauth2/callback'
    visit root_path
    current_month_year = Date.current.strftime('%B %Y')
    click_on 'Next'
    next_month_year = (Date.current + 1.month).strftime('%B')
    expect(page).to have_content(next_month_year)
    expect(page).not_to have_content(current_month_year)
  end

  it 'should display the previous month accordingly when the previous button is clicked' do
    visit '/admins/auth/google_oauth2/callback'
    visit root_path
    current_month_year = Date.current.strftime('%B %Y')
    click_on 'Previous'
    previous_month_year = (Date.current - 1.month).strftime('%B')
    expect(page).to have_content(previous_month_year)
    expect(page).not_to have_content(current_month_year)
  end
end

RSpec.describe 'Event Check In', type: :feature do    
  let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  let!(:event) { Event.create(name: 'event name', description: 'event description', start: '2023-3-20', end: '2023-3-21', type_id: '3', status: 'ongoing', points:30) }
  
  context 'when user has already checked in to event' do
    it 'displays a message that user checked in before' do
      UserEvent.create(user_id: user.id, event_id: event.id, checked: true)
      visit '/admins/auth/google_oauth2/callback'
      visit pages_event_sign_in_path
      fill_in 'uin', with: user.uin
      fill_in 'event_id', with: event.id
      click_button 'Check User into Event'
      expect(page).to have_content('The user checked in this event before!')
    end
  end

  context 'when user has not checked in to event' do
    before(:each) do
      UserEvent.create(user_id: user.id, event_id: event.id, checked: false)
      @count_before_click = event.count
      visit '/admins/auth/google_oauth2/callback'
      visit pages_event_sign_in_path
      fill_in 'uin', with: user.uin
      fill_in 'event_id', with: event.id
      click_button 'Check User into Event'        
      @count_after_click = event.reload.count
    end      

    it 'displays a message that user checked in succesfully' do
      expect(page).to have_content('The user checked in this event succesfully.')
    end

    it 'event count increment' do
      expect(@count_after_click).to eq(@count_before_click + 1)
    end
  end  
end

RSpec.describe 'User Points Reset', type: :feature do    
  let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '10', role_id: '1') }

  context 'when click the reset button' do
    it 'displays a message that user points reset succesfully' do
      visit '/admins/auth/google_oauth2/callback'
      visit pages_reset_user_points_path
      fill_in 'uin', with: user.uin
      click_button 'Reset User Points'
      expect(page).to have_content('User points succesfully reset to zero')
    end
  end
end

RSpec.describe DeleteEntriesWorker, type: :worker do
  describe '#perform' do
    it 'deletes users created 4 years ago' do
      user = User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1', created_at: 4.years.ago)
      expect {
        DeleteEntriesWorker.new.perform
      }.to change(User, :count).by(-1)
      expect(User.exists?(user.id)).to eq(false)
    end

    it 'does not delete users created less than 4 years ago' do
      user = User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1', created_at: 3.years.ago)
      expect {
        DeleteEntriesWorker.new.perform
      }.not_to change(User, :count)
      expect(User.exists?(user.id)).to eq(true)
    end
  end
end

RSpec.describe ResetUserPointsWorker, type: :worker do
  describe '#perform' do
    let!(:user1) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '10', role_id: '1') }
    let!(:user2) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student2@tamu.edu', dob: '2003-10-10', points: '5', role_id: '1') }
    let!(:user3) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student3@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }

    it 'sets the points attribute to 0 for all users' do
      expect {
        ResetUserPointsWorker.new.perform
        user1.reload
        user2.reload
        user3.reload
      }.to change { user1.points }.from(10).to(0)
       .and change { user2.points }.from(5).to(0)
       .and change { user3.points }.from(3).to(0)
    end
  end
end

RSpec.describe('Creating an Event', type: :feature) do
  let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  scenario 'valid inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_event_path
    fill_in "event[start]", with: '2023-3-20'
    fill_in "event[end]", with: '2023-3-21'
    fill_in "event[name]", with: 'Event thingy'
    fill_in "event[points]", with: '3'
    fill_in "event[description]", with: 'description'
    fill_in "event[status]", with: 'ongoing'
    click_on 'Save'
    expect(page).to have_content('successfully')
  end

  scenario 'blank inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_event_path
    click_on 'Save'
    expect(page).to have_content('prohibited this event from being saved:')
  end
end


RSpec.describe('Modifying an Event', type: :feature) do
  let!(:event) { Event.create(name: 'event name', description: 'event description', start: '2023-3-20', end: '2023-3-21', type_id: '3', status: 'ongoing', points:30) }
  scenario 'valid modification' do
    visit '/admins/auth/google_oauth2/callback'
    visit edit_event_path(event)
    fill_in "event[status]", with: 'ended'
    click_on 'Save'
    expect(page).to have_content('successfully')
  end

  scenario 'blank input' do
    visit '/admins/auth/google_oauth2/callback'
    visit edit_event_path(event)
    fill_in "event[status]", with: ''
    click_on 'Save'
    expect(page).to have_content('prohibited')
  end
end

RSpec.describe('Deleting an Event', type: :feature) do
  let!(:event) { Event.create(name: 'event name', description: 'event description', start: '2023-3-20', end: '2023-3-21', type_id: '3', status: 'ongoing', points:30) }
  scenario 'valid deletion' do
    visit '/admins/auth/google_oauth2/callback'
    visit event_path(event)
    click_on 'Delete'
    expect(page).to have_content('successfully')
  end
end

RSpec.describe('Visiting the Help page', type: :feature) do
  let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  scenario 'valid visit' do
    visit '/admins/auth/google_oauth2/callback'
    visit help_user_path(id: user.id)
    expect(page).to have_content('Help')
  end
end
