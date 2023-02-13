# basic role model, validates that all inputs are in
class Role < ApplicationRecord
  validates :role_name, :create_event, :delete_event, :edit_event, :delete_member, :promote_member, presence: true
end
