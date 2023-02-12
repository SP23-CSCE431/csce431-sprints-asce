require "application_system_test_case"

class UserEventsTest < ApplicationSystemTestCase
  setup do
    @user_event = user_events(:one)
  end

  test "visiting the index" do
    visit user_events_url
    assert_selector "h1", text: "User events"
  end

  test "should create user event" do
    visit user_events_url
    click_on "New user event"

    fill_in "Event", with: @user_event.event_id
    fill_in "User", with: @user_event.user_id
    click_on "Create User event"

    assert_text "User event was successfully created"
    click_on "Back"
  end

  test "should update User event" do
    visit user_event_url(@user_event)
    click_on "Edit this user event", match: :first

    fill_in "Event", with: @user_event.event_id
    fill_in "User", with: @user_event.user_id
    click_on "Update User event"

    assert_text "User event was successfully updated"
    click_on "Back"
  end

  test "should destroy User event" do
    visit user_event_url(@user_event)
    click_on "Destroy this user event", match: :first

    assert_text "User event was successfully destroyed"
  end
end
