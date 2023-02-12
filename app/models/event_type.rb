class EventType < ApplicationRecord
  validate :points, presence: true
end
