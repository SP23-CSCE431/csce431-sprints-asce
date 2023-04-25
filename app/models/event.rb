class Event < ApplicationRecord
  has_many :event_types, class_name: 'event_type', foreign_key: 'event_type_id'
  validates :start, :end, :status, :type_id, presence: true
  # ensures that if an event is deleted, all associated user events are also deleted
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events

  def self.ransackable_attributes(_auth_object = nil)
    ['name']
  end

  def self.ransackable_associations(_auth_object = nil)
    ['']
  end
end
