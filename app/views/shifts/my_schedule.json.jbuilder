json.array!(@my_schedule) do |shift|
  json.extract! shift, *Shift.column_names
end
