json.array!(@shift_reports) do |shift_report|
  json.extract! shift_report, *ShiftReport.column_names

  json.location do
    json.id shift_report.location.id
    json.name shift_report.location.name
  end

  json.user do
    json.id shift_report.user.id
    json.first_name shift_report.user.first_name
    json.last_name shift_report.user.last_name
  end

  json.url shift_report_url(shift_report)
end
