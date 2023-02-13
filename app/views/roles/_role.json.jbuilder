json.extract!(role, :id, :role_name, :create_event, :delete_event, :edit_event, :delete_member, :promote_member, :created_at, :updated_at)
json.url(role_url(role, format: :json))
