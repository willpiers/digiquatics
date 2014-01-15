json.array!(@help_desks) do |help_desk|
  json.extract! help_desk, :id, :name, :type
  json.url help_desk_url(help_desk, format: :json)
end
