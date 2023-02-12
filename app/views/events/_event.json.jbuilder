json.extract! event, :id, :start, :end, :status, :type_id, :created_at, :updated_at
json.url event_url(event, format: :json)
