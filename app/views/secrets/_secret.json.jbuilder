json.extract! secret, :id, :encrypted_secret, :created_at, :updated_at
json.url secret_url(secret, format: :json)
