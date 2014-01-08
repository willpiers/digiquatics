json.array!(@locations) do |location|
  json.extract! location, :name, :account_id
  json.url location_url(location, format: :json)
end
