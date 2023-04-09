class UserEvent < ApplicationRecord
  #when a user is destroyed all their corresponding signed up events will be destroyed as well
  belongs_to :user
  belongs_to :event
  #ensures both user_id and event_id are present when creating or updating UserEvent instance
  validates :user_id, :event_id, presence: true
  #ensures a user cannot sign up for the same event twice
  validates :user_id, uniqueness: { scope: :event_id, message: "You have already signed up for this event" }
end
