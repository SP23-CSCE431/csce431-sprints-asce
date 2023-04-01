# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create Roles
admin_role = Role.create!(role_name: "admin", create_event: true, delete_event: true, edit_event: true, delete_member: true, promote_member: true)
user_role = Role.create!(role_name: "user", create_event: false, delete_event: false, edit_event: false, delete_member: false, promote_member: false)

# Create Users
admin_user = User.create!(first_name: "Admin", last_name: "User", uin: "123456789", email: "admin@example.com", phone_number: "123-456-7890", dob: Date.new(1990, 1, 1), points: 0, role: admin_role)
user1 = User.create!(first_name: "John", last_name: "Doe", uin: "123456789", email: "john.doe@example.com", phone_number: "123-456-7890", dob: Date.new(1990, 1, 1), points: 0, role: user_role)
user2 = User.create!(first_name: "Jane", last_name: "Doe", uin: "123456789", email: "jane.doe@example.com", phone_number: "123-456-7890", dob: Date.new(1990, 1, 1), points: 0, role: user_role)