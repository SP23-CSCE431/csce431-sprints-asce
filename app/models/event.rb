class Event < ApplicationRecord
  has_many :event_types, class_name: 'event_type', foreign_key: 'event_type_id'
  validates :start, :end, :status, :type_id, presence: true
  has_many :user_events, dependent: :destroy
  
  def self.ransackable_attributes(auth_object = nil)
    [  "name" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [  ""]
  end
end
