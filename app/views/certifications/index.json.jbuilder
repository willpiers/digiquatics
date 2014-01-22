json.array!(@certifications) do |certification|
  json.extract! certification, :certification_name_id, :user_id,
    :expiration_date
  json.url certification_url(certification, format: :json)
end
