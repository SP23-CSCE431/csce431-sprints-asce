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
end

#RSpec.describe 'Creating an Event', type: :feature do
    #scenario 'valid inputs' do
      #visit new_event_path
      #fill_in "event[start]", with: '2023-10-10'
      #fill_in "event[end]", with: '2023-10-11'
      #fill_in "event[type_id]", with: '1'
      #fill_in "event[status]", with: 'ongoing'
      #click_on 'Create Event'
      #visit events_path
      #expect(page).to have_content('2023-10-10')
    #end
  #end

