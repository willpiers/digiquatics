json.array!(@positions) do |position|
  json.extract! position, :name, :account_id
  json.url position_url(position, format: :json)
end
