class Event < ApplicationRecord
  has_many :event_types, class_name: 'event_type', foreign_key: 'event_type_id'
  validates :start, :end, :status, :type_id, presence: true
end
