class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :user_id, :event_id, presence: true
  validates :user_id, uniqueness: { scope: :event_id, message: "You have already signed up for this event" }
end
