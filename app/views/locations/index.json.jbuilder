json.array!(@locations) do |location|
  json.extract! location, :id, :name, :account_id
  json.url location_url(location, format: :json)
end
