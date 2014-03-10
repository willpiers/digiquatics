json.array!(@help_desks) do |help_desk|
  json.extract! help_desk, *HelpDesk.column_names

  json.url help_desk_url(help_desk)
end
