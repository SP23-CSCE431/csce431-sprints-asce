class User < ApplicationRecord
  has_many :roles, class_name: 'role', foreign_key: 'role_id'
  validates :first_name, :last_name, :uin, :email, :phone_number, :dob, :points, :role_id, presence: true
  has_many :user_events
  has_many :events, through: :user_events

  def self.ransackable_attributes(auth_object = nil)
    [  "first_name", "last_name", "uin"]
  end

  def self.ransackable_associations(auth_object = nil)
    [  ""]
  end
  
end
