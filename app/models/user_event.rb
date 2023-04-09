class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  #ensures a user cannot sign up for the same event twice
  validates :user_id, uniqueness: { scope: :event_id, message: "You have already signed up for this event" }
end
