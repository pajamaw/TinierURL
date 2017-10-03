json.extract! short_link, :id, :slug, :visited, :destination, :created_at, :updated_at
json.url short_link_url(short_link, format: :json)
