# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

x = false

Roles = Role.create!(
  [
    {
      role_name: 'Member',
      create_event: x,
      edit_event: x,
      delete_event: x,
      delete_member: x,
      promote_member: x
    },
    {
      role_name: 'Officer',
      create_event: x,
      edit_event: x,
      delete_event: x,
      delete_member: x,
      promote_member: x
    },
    {
      role_name: 'Executive Officer',
      create_event: true,
      edit_event: true,
      delete_event: true,
      delete_member: true,
      promote_member: true
    }
  ]
)
