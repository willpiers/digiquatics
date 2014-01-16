json.array!(@shift_reports) do |shift_report|
  json.extract! shift_report, :id, :post_title
  json.url shift_report_url(shift_report, format: :json)
end
