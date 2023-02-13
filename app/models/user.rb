class User < ApplicationRecord
  has_many :roles, class_name: 'role', foreign_key: 'role_id'
  validates :first_name, :last_name, :uin, :email, :phone_number, :dob, :points, :role_id, presence: true
end
