json.array!(@positions) do |position|
  json.extract! position, :id, :name
end
