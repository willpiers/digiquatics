json.array!(@certification_names) do |certification_name|
  json.extract! certification_name, :account_id, :name
  json.url certification_name_url(certification_name, format: :json)
end
