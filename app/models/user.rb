class User < ApplicationRecord
  belongs_to :role, class_name: 'Role', foreign_key: 'role_id'
  validates :first_name, :last_name, :uin, :email, :phone_number, :dob, :points, :role_id, presence: true
  validates :email, :uniqueness => true, format: { with: /\A[^@\s]+@tamu\.edu\z/i, message: "must be a tamu email" }
  has_many :user_events
  has_many :events, through: :user_events

  def self.ransackable_attributes(auth_object = nil)
    [  "first_name", "last_name", "uin"]
  end

  def self.ransackable_associations(auth_object = nil)
    [  ""]
  end
  
end
