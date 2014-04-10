json.array!(@chemical_records) do |chemical_record|
  json.extract! chemical_record, *ChemicalRecord.column_names

  json.pool do
    json.id          chemical_record.pool.id
    json.name        chemical_record.pool.name
    json.location_id chemical_record.pool.location_id
    json.location    chemical_record.pool.location
  end

  json.user do
    json.id           chemical_record.user.id
    json.first_name   chemical_record.user.first_name
    json.last_name    chemical_record.user.last_name
  end

  json.url chemical_record_url(chemical_record)
end
