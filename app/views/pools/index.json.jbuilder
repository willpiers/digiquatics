json.array!(@pools) do |pool|
  json.extract! pool, :id, :name, :location_id
  json.url pool_url(pool, format: :json)
end
