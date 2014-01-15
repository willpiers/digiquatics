json.array!(@attendance_records) do |attendance_record|
  json.extract! attendance_record, :id, :name
  json.url attendance_record_url(attendance_record, format: :json)
end
