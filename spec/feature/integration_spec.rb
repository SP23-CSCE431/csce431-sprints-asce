# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a user', type: :feature do
  scenario 'valid inputs' do
    visit new_user_path
    fill_in "user[first_name]", with: 'harry'
    fill_in "user[last_name]", with: 'potter'
    fill_in "user[uin]", with: '730303030'
    fill_in "user[email]", with: 'student@tamu.edu'
    fill_in "user[phone_number]", with: '1234567898'
    fill_in "user[dob]", with: '2003-10-10'
    click_on 'Create User'
    visit users_path
    expect(page).to have_content('harry')
  end

  scenario 'blank inputs' do
    visit new_user_path
    click_on 'Create User'
    expect(page).to have_content('prohibited this user from being saved:')
  end

  scenario 'invalid uin' do
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

# Rspec.describe 'Deleting Personal Account', type: :feature do
#   scenario 'valid deletion' do
#     expect(page.to) have_content('placeholder')
#   end
  
#   scenario 'invalid deletion' do
#     expect(page.to) have_content('placeholder')
#   end
# end

# Rspec.describe 'Editing Personal Account',
#   scenario 'valid edit' do
#     expect(page.to) have_content('placeholder')
#   end

#   scenario 'invalid edit' do
#     expect(page.to) have_content('placeholder')
#   end
# end

# RSpec.describe 'Creating an Event', type: :feature do
#   scenario 'valid inputs' do
#     visit new_event_path
#     fill_in "event[start]", with: '2023-10-10'
#     fill_in "event[end]", with: '2023-10-11'
#     fill_in "event[type_id]", with: '1'
#     fill_in "event[status]", with: 'ongoing'
#     click_on 'Create Event'
#     visit events_path
#     expect(page).to have_content('2023-10-10')
#   end

#   scenario 'blank inputs' do
#     visit new_event_path
#     click_on 'Create Event'
#     expect(page).to have_content('ERROR: fill all fields')
#   end

#   scenario 'invalid date' do
#     fill_in "event[start]", with: '2022-10-10'
#     fill_in "event[end]", with: '2023-10-11'
#     fill_in "event[type_id]", with: '1'
#     fill_in "event[status]", with: 'ongoing'
#     click_on 'Create Event'
#     expect(page).to have_content('ERROR: input date cannot be before current date')
#   end
# end

# Rspec.describe 'Modifying an Event', type: :feature do
#   scenario 'valid modification' do
#     expect(page.to) have_content('placeholder')
#   end

#   scenario 'invalid modification' do
#     expect(page.to) have_content('placeholder')
#   end
# end

# Rspec.describe 'Deleting an Event', type: :feature do
#   scenario 'valid deletion' do
#     expect(page.to) have_content('placeholder')
#   end

#   scenario 'invalid deletion' do
#     expect(page.to) have_content('placeholder')
#   end
# end

# RSpec.describe 'Searching a User', type: :feature do
#   scenario 'user exists' do
#     visit users_path
#     fill_in "params[search_by_first_name]", with 'Anthony'
#     expect(page).to have_content('adao102@tamu.edu')
#   end
#   scenario 'user does not exist' do
#     visit users_path
#     fill_in "params[search_by_first_name]", with 'NonexistentUser'
#     expect(page).to have_content('No matching user exists')
#   end
# end

# Rspec.describe 'Signing members into event' do
#   scenario 'Valid UIN' 
#   expect(page.to) have_content('placeholder')
#   end

#   scenario 'Invalid UIN' do
#     expect(page.to) have_content('placeholder')
#   end

#   scenario 'Sign member in more than once' do
#     expect(page.to) have_content('placeholder')
#   end
# end

# Rspec.describe 'Change member status' do
#   scenario 'promote member' do
#     expect(page.to) have_content('placeholder')
#   end

#   scenario 'demote officer' do
#     expect(page.to) have_content('placeholder')
#   end

#   scenario 'demote member (rainy)' do
#     expect(page.to) have_content('placeholder')
#   end

#   scenario 'demote executive officer (rainy)' 
#   expect(page.to) have_content('placeholder')
#   end
# end

# Rspec.describe 'Delete other members' do
#   scenario 'delete member' do
#     expect(page.to) have_content('placeholder')
#   end

#   scenario 'delete officer' do
#     expect(page.to) have_content('placeholder')
#   end
  
#   scenario 'delete executive officer (rainy)' do
#     expect(page.to) have_content('placeholder')
#   end
# end

# Rspec.describe 'view events in google calender' do
#   scenario 'check events' do
#     expect(page.to) have_content('placeholder')
#   end

#   scenario 'no events' do
#     expect(page.to) have_content('placeholder')
#   end
# end

# Rspec.describe 'Manage user points' do
#   scenario 'Add points to user' do
#     expect(page.to) have_content('placeholder')
#   end

#   scenario 'Delete points from user' do
#     expect(page.to) have_content('placeholder')
#   end

#   scenario 'Negative points' do
#     expect(page.to) have_content('placeholder')
#   end 
# end

