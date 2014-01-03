json.array!(@chemical_records) do |chemical_record|
  json.extract! chemical_record, :chlorine_ppm, :chlorine_orp, :ph, 
  	:alkalinity, :calcium_hardness, :pool_temp, :air_temp, :si_index
  json.url chemical_record_url(chemical_record, format: :json)
end
