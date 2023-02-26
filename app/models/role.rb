# basic role model, validates that all inputs are in
class Role < ApplicationRecord
  validates :role_name, presence: true
  validates :create_event, :delete_event, :edit_event, :delete_member, :promote_member, inclusion: { in: [true, false] }
end
