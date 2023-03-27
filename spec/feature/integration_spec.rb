# location: spec/feature/integration_spec.rb
require 'rails_helper'

# it 'should create a new user after Google OAuth authentication' do
#   visit '/admins/auth/google_oauth2/callback'
#   expect(page).to have_content 'Welcome'
# end
# it "displays the correct content" do
#   visit '/admins/auth/google_oauth2/callback'
#   visit new_user_path
#   expect(page).to have_content "New user"
# end
RSpec.describe('Authentication Test', type: :feature) do
  it 'valid authentication' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to(have_content('You\'re logged in!'))
  end
end

RSpec.describe('Creating a user', type: :feature) do
  it 'valid inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_path
    fill_in 'user[first_name]', with: 'harry'
    fill_in 'user[last_name]', with: 'potter'
    fill_in 'user[uin]', with: '730303030'
    fill_in 'user[email]', with: 'student@tamu.edu'
    fill_in 'user[phone_number]', with: '1234567898'
    fill_in 'user[dob]', with: '2003-10-10'
    fill_in 'user[role_id]', with: '2'
    click_on 'Create User'
    expect(page).to(have_content('User was successfully created'))
  end

  it 'blank inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_path
    click_on 'Create User'
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
    click_on 'Create User'
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
    click_on 'Create User'
    expect(page).to(have_content('prohibited this user from being saved:'))
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
    expect(page).to(have_content(user.id))
  end

  it 'blank inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_event_path
    click_on 'Add Event'
    expect(page).to(have_content('2 errors prohibited this user_event from being saved'))
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

RSpec.describe('Calendar:', type: :feature) do
  let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
  let!(:event1) { Event.create(start: '2023-3-20', end: '2023-3-21', type_id: '3', status: 'ongoing', name: 'Event 1', description: 'This is Event 1') }
  let!(:event2) { Event.create(start: '2022-11-10', end: '2023-11-10', type_id: '3', status: 'ongoing', name: 'Event 2', description: 'This is Event 2') }

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

# RSpec.describe('Deleting Personal Account', type: :feature) do
#   let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
#   scenario 'valid deletion' do
#     visit '/admins/auth/google_oauth2/callback'
#     visit user_url
#     click_on 'Destroy'
#     expect(page).to have_content('User was successfully destroyed')
#   end
# end

# RSpec.describe('Editing Personal Account' , type: :feature) do
#   scenario 'valid edit' do
#     visit '/admins/auth/google_oauth2/callback'
#     click_on 'All Users'
#     click_on 'Show this user'
#     click_on 'Edit'
#     fill_in 'user[first_name]', with: 'harry'
#     click_on 'Update'
#     expect(page).to have_content('successfully')
#   end

#   scenario 'invalid edit' do
#     click_on 'All Users'
#     click_on 'Show this user'
#     click_on 'Edit'
#     fill_in 'user[first_name]', with: ''
#     click_on 'Update'
#     expect(page).to have_content('error')
#   end
# end

# RSpec.describe('Creating an Event', type: :feature) do
#   let!(:user) { User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob: '2003-10-10', points: '3', role_id: '1') }
#   scenario 'valid inputs' do
#     visit '/admins/auth/google_oauth2/callback'
#     click_on 'Events'
#     click_on 'New event'
#     fill_in "event[start]", with: '03/26/2023 03:26 AM'
#     fill_in "event[end]", with: '03/27/2023 04:26 PM'
#     fill_in "event[type_id]", with: '1'
#     fill_in "event[status]", with: 'ongoing'
#     click_on 'Create'
#     expect(page).to have_content('successfully')
#   end

#   scenario 'blank inputs' do
#     visit '/admins/auth/google_oauth2/callback'
#     click_on 'Events'
#     click_on 'New event'
#     fill_in "event[start]", with: ''
#     fill_in "event[end]", with: '03/27/2023 04:26 PM'
#     fill_in "event[type_id]", with: '1'
#     fill_in "event[status]", with: 'ongoing'
#     click_on 'Create'
#     expect(page).to have_content('error')
#   end
# end

# RSpec.describe('Modifying an Event', type: :feature) do
#   let!(:event) { Event.create(start: '2022-10-10', end: '2023-10-10', type_id: '3', status: 'ongoing') }
#   scenario 'valid modification' do
#     visit '/admins/auth/google_oauth2/callback'
#     click_on 'Events'
#     click_on 'Show this event'
#     click_on 'Edit'
#     fill_in "event[status]", with: 'ended'
#     click_on 'Update'
#     expect(page).to have_content('successfully')
#   end

#   scenario 'invalid modification' do
#     click_on 'Events'
#     click_on 'Show this event'
#     click_on 'Edit'
#     fill_in "event[status]", with: ''
#     click_on 'Update'
#     expect(page).to have_content('error')
#   end
# end

# RSpec.describe('Deleting an Event', type: :feature) do
#   let!(:event) { Event.create(start: '2022-10-10', end: '2023-10-10', type_id: '3', status: 'ongoing') }
#   scenario 'valid deletion' do
#     visit '/admins/auth/google_oauth2/callback'
#     click_on 'Events'
#     click_on 'Show this event'
#     click_on 'Destroy'
#     expect(page).to have_content('successfully')
#   end
# end

# RSpec.describe('Searching a User', type: :feature) do
#   scenario 'user exists' do
#     visit '/admins/auth/google_oauth2/callback'
#     visit users_path
#     fill_in "params[search_by_first_name]", with: 'Anthony'
#     expect(page).to have_content('adao102@tamu.edu')
#   end
#   scenario 'user does not exist' do
#     visit '/admins/auth/google_oauth2/callback'
#     visit users_path
#     fill_in "params[search_by_first_name]", with: 'NonexistentUser'
#     expect(page).to have_content('No matching user exists')
#   end
# end

# RSpec.describe('Signing members into event' , type: :feature) do

#   scenario 'Valid UIN' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end

#   scenario 'Invalid UIN' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end

#   scenario 'Sign member in more than once' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end
# end

# RSpec.describe('Change member status' , type: :feature) do
#   scenario 'promote member' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end

#   scenario 'demote officer' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end

#   scenario 'demote member (rainy)' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end

#   scenario 'demote executive officer (rainy)' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end
# end

# RSpec.describe('Delete other members' , type: :feature) do
#   scenario 'delete member' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end

#   scenario 'delete officer' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end

#   scenario 'delete executive officer (rainy)' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end
# end

# RSpec.describe('view events in google calender' , type: :feature) do
#   scenario 'check events' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end

#   scenario 'no events' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end
# end

# RSpec.describe('Manage user points' , type: :feature) do
#   scenario 'Add points to user' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end

#   scenario 'Delete points from user' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end

#   scenario 'Negative points' do
#     visit '/admins/auth/google_oauth2/callback'
#     expect(page).to have_content('placeholder')
#   end
# end