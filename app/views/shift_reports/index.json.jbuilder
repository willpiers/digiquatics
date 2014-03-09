json.array!(@shift_reports) do |shift_report|
  json.extract! shift_report, *ShiftReport.column_names

  json.url shift_report_url(shift_report)
end
