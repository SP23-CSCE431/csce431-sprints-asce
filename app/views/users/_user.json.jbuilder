json.extract! user, :id, :first_name, :last_name, :uin, :email, :phone_number, :dob, :points, :role_id, :created_at, :updated_at
json.url user_url(user, format: :json)
