json.array!(@attendance_records) do |attendance_record|
  json.extract! attendance_record, :0500_0600, :0600_0700, :0700_0800, 
  	:0800_0900, :0900_1000, :1000_1100, :1100_1200, :pool_id
  json.url attendance_record_url(attendance_record, format: :json)
end
