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
  scenario 'valid authentication' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('You\'re logged in!')
  end
end

RSpec.describe('Creating a user', type: :feature) do
  scenario 'valid inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_path
    fill_in "user[first_name]", with: 'harry'
    fill_in "user[last_name]", with: 'potter'
    fill_in "user[uin]", with: '730303030'
    fill_in "user[email]", with: 'student@tamu.edu'
    fill_in "user[phone_number]", with: '1234567898'
    fill_in "user[dob]", with: '2003-10-10'
    fill_in "user[points]", with: '3'
    fill_in "user[role_id]", with: '2'
    click_on 'Create User'
    expect(page).to have_content('User was successfully created')
  end

  scenario 'blank inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_path
    click_on 'Create User'
    expect(page).to have_content('prohibited this user from being saved:')
  end

  scenario 'invalid uin' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_path
    fill_in "user[first_name]", with: 'harry'
    fill_in "user[last_name]", with: 'potter'
    fill_in "user[uin]", with: 'abcdefg'
    fill_in "user[email]", with: 'student@tamu.edu'
    fill_in "user[phone_number]", with: '1234567898'
    fill_in "user[dob]", with: '2003-10-10'
    click_on 'Create User'
    expect(page).to have_content('prohibited this user from being saved:')
  end

  scenario 'invalid email' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_path
    fill_in "user[first_name]", with: 'harry'
    fill_in "user[last_name]", with: 'potter'
    fill_in "user[uin]", with: 'abcdefg'
    fill_in "user[email]", with: 'student@gmail.com'
    fill_in "user[phone_number]", with: '1234567898'
    fill_in "user[dob]", with: '2003-10-10'
    click_on 'Create User'
    expect(page).to have_content('prohibited this user from being saved:')
  end
end

RSpec.describe('Deleting Personal Account', type: :feature) do
  scenario 'valid deletion' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end
  
  scenario 'invalid deletion' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end
end

RSpec.describe('Editing Personal Account' , type: :feature) do
  scenario 'valid edit' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'invalid edit' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end
end

RSpec.describe('Creating an Event', type: :feature) do
  scenario 'valid inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_event_path
    fill_in "event[start]", with: '2023-10-10'
    fill_in "event[end]", with: '2023-10-11'
    fill_in "event[type_id]", with: '1'
    fill_in "event[status]", with: 'ongoing'
    click_on 'Create Event'
    visit events_path
    expect(page).to have_content('2023-10-10')
  end

  scenario 'blank inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_event_path
    click_on 'Create Event'
    expect(page).to have_content('ERROR: fill all fields')
  end

  scenario 'invalid date' do
    visit '/admins/auth/google_oauth2/callback'
    fill_in "event[start]", with: '2022-10-10'
    fill_in "event[end]", with: '2023-10-11'
    fill_in "event[type_id]", with: '1'
    fill_in "event[status]", with: 'ongoing'
    click_on 'Create Event'
    expect(page).to have_content('ERROR: input date cannot be before current date')
  end
end

RSpec.describe('Modifying an Event', type: :feature) do
  scenario 'valid modification' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'invalid modification' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end
end

RSpec.describe('Deleting an Event', type: :feature) do
  scenario 'valid deletion' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'invalid deletion' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end
end

RSpec.describe('Searching a User', type: :feature) do
  scenario 'user exists' do
    visit '/admins/auth/google_oauth2/callback'
    visit users_path
    fill_in "params[search_by_first_name]", with: 'Anthony'
    expect(page).to have_content('adao102@tamu.edu')
  end
  scenario 'user does not exist' do
    visit '/admins/auth/google_oauth2/callback'
    visit users_path
    fill_in "params[search_by_first_name]", with: 'NonexistentUser'
    expect(page).to have_content('No matching user exists')
  end
end

RSpec.describe('Signing members into event' , type: :feature) do
  
  scenario 'Valid UIN' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'Invalid UIN' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'Sign member in more than once' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end
end

RSpec.describe('Change member status' , type: :feature) do
  scenario 'promote member' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'demote officer' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'demote member (rainy)' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'demote executive officer (rainy)' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end
end

RSpec.describe('Delete other members' , type: :feature) do
  scenario 'delete member' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'delete officer' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end
  
  scenario 'delete executive officer (rainy)' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end
end

RSpec.describe('view events in google calender' , type: :feature) do
  scenario 'check events' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'no events' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end
end

RSpec.describe('Manage user points' , type: :feature) do
  scenario 'Add points to user' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'Delete points from user' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end

  scenario 'Negative points' do
    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content('placeholder')
  end 
end

RSpec.describe('Member Signing Up for an Event', type: :feature) do
  let!(:user) {User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob:'2003-10-10', points:'3', role_id:'1')}
  let!(:event) {Event.create(start: '2022-10-10', end: '2023-10-10', type_id: '3', status: 'ongoing')}
  
  scenario 'valid inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_event_path
    fill_in "user_event[user_id]", with: user.id
    fill_in "user_event[event_id]", with: event.id
    click_on 'Create User event'
    visit user_events_path
    expect(page).to have_content(user.id)
  end

  scenario 'blank inputs' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_event_path
    click_on 'Create User event'
    expect(page).to have_content('2 errors prohibited this user_event from being saved')
  end

  scenario 'invalid event' do
    visit '/admins/auth/google_oauth2/callback'
    visit new_user_event_path
    fill_in "user_event[user_id]", with: user.id
    fill_in "user_event[event_id]", with: ' '
    click_on 'Create User event'
    expect(page).to have_content('Event must exist')
  end
end

RSpec.describe('Updating a UserEvent', type: :feature) do
  let!(:user) {User.create(first_name: 'Joe', last_name: 'Shmoe', uin: '730303036', phone_number: '8324344445', email: 'student@tamu.edu', dob:'2003-10-10', points:'3', role_id:'1')}
  let!(:event1) {Event.create(start: '2022-10-10', end: '2023-10-10', type_id: '3', status: 'ongoing')}
  let!(:event2) {Event.create(start: '2022-11-10', end: '2023-11-10', type_id: '3', status: 'ongoing')}
  let!(:user_event) {UserEvent.create(user_id: user.id, event_id: event1.id)}
  
  scenario 'valid update' do
    visit '/admins/auth/google_oauth2/callback'
    visit edit_user_event_path(user_event)
    fill_in "user_event[user_id]", with: user.id
    fill_in "user_event[event_id]", with: event2.id
    click_on 'Update User event'
    visit user_events_path
    expect(page).to have_content(user.id)
  end

  scenario 'invalid update due to nonexistent event' do
    visit '/admins/auth/google_oauth2/callback'
    visit edit_user_event_path(user_event)
    fill_in "user_event[user_id]", with: user.id
    fill_in "user_event[event_id]", with: '20'
    click_on 'Update User event'
    expect(page).to have_content('Event must exist')
  end
end

