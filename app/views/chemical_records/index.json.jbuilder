json.array!(@chemical_records) do |chemical_record|
  json.extract! chemical_record, *ChemicalRecord.column_names

  json.pool do
    json.id          chemical_record.pool.id
    json.name        chemical_record.pool.name
  end

  json.location do
    json.id          chemical_record.location.id
    json.name        chemical_record.location.name
  end

  # json.url chemical_record_url(chemical_record)
end
