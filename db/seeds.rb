# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Create Roles
executive_officer_role = Role.create!(role_name: "executive_officer", create_event: true, delete_event: true, edit_event: true, delete_member: true, promote_member: true)
admin_role = Role.create!(role_name: "officer", create_event: true, delete_event: true, edit_event: true, delete_member: true, promote_member: true)
member_role = Role.create!(role_name: "member", create_event: false, delete_event: false, edit_event: false, delete_member: false, promote_member: false)

# Create Users
executive_officer = User.create!(first_name: "Timothy", last_name: "Short", uin: "327008959", email: "timo.short@tamu.edu", phone_number: "9039186036", dob: Date.new(1990, 1, 1), points: 0, role_id: executive_officer_role.id)
executive_officer = User.create!(first_name: "Anthony", last_name: "Dao", uin: "828006672", email: "adao102@tamu.edu", phone_number: "7132547212", dob: Date.new(1990, 1, 1), points: 0, role_id: executive_officer_role.id)
executive_officer = User.create!(first_name: "Pranav", last_name: "Vankamamidi", uin: "327008959", email: "vpranav@tamu.edu", phone_number: "9039186036", dob: Date.new(1990, 1, 1), points: 0, role_id: executive_officer_role.id)
executive_officer = User.create!(first_name: "David", last_name: "Vilentchouk", uin: "327008959", email: "bannerdavid@tamu.edu", phone_number: "9039186036", dob: Date.new(1990, 1, 1), points: 0, role_id: executive_officer_role.id)
executive_officer = User.create!(first_name: "Zhan", last_name: "Lan", uin: "327008959", email: "zhanlan@tamu.edu", phone_number: "9039186036", dob: Date.new(1990, 1, 1), points: 0, role_id: executive_officer_role.id)
admin_user = User.create!(first_name: "Officer", last_name: "User", uin: "123456789", email: "officer@tamu.edu", phone_number: "123-456-7890", dob: Date.new(1990, 1, 1), points: 0, role_id: admin_role.id)
user1 = User.create!(first_name: "John", last_name: "Doe", uin: "123456789", email: "john.doe@tamu.edu", phone_number: "123-456-7890", dob: Date.new(1990, 1, 1), points: 0, role_id: member_role.id)
user2 = User.create!(first_name: "Jane", last_name: "Doe", uin: "123456789", email: "jane.doe@tamu.edu", phone_number: "123-456-7890", dob: Date.new(1990, 1, 1), points: 0, role_id: member_role.id)



