class User < ApplicationRecord
  has_many :roles, class_name: 'role', foreign_key: 'role_id'
  validates :first_name, :last_name, :uin, :email, :phone_number, :dob, :points, :role_id, presence: true
  #validates the the email is unique (no duplicates) and that it is a tamu email
  validates :email, :uniqueness => true, format: { with: /\A[^@\s]+@tamu\.edu\z/i, message: "Must be a tamu email" }
  #validates that the uin is a 9 digit number
  validates :uin, format: { with: /\A\d{9}\z/, message: "must be a 9 digit number" }
  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events

  def self.ransackable_attributes(auth_object = nil)
    [  "first_name", "last_name", "uin"]
  end

  def self.ransackable_associations(auth_object = nil)
    [  ""]
  end
  
end
