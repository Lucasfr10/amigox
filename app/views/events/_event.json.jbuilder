json.extract! event, :id, :name, :group_id, :raffled, :created_at, :updated_at
json.url event_url(event, format: :json)