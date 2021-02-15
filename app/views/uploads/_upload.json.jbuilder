json.extract! upload, :id, :year, :user_id, :created_at, :updated_at
json.url upload_url(upload, format: :json)
