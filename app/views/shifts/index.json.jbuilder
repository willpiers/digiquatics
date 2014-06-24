json.array!(@shifts) do |shift|
  json.extract! shift, *Shift.column_names
end
