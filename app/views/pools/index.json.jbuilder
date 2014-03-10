json.array!(@pools) do |pool|
  json.extract! pool, :id, :name, :location_id

  json.location do
    json.id   pool.location_id
    json.name pool.location.name
  end

  json.url pool_url(pool, format: :json)
end
