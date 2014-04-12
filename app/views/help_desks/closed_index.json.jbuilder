json.array!(@closed_index) do |help_desk|
  json.extract! help_desk, *HelpDesk.column_names

  json.location do
    json.id          help_desk.location.id
    json.name        help_desk.location.name
  end

  json.user do
    json.id          help_desk.user.id
    json.first_name  help_desk.user.first_name
    json.last_name   help_desk.user.last_name
  end

  json.attachment_url help_desk.help_desk_attachment
  json.url help_desk_url(help_desk)
end
