json.array!(@email_groups) do |email_group|
  json.extract! email_group, :id
  json.url email_group_url(email_group, format: :json)
end
