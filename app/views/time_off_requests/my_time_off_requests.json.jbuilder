json.array!(@my_time_off_requests) do |request|
  json.extract! request, *TimeOffRequest.column_names

  json.user do
    json.id request.user.id
    json.first_name request.user.first_name
    json.last_name request.user.last_name
  end
end
