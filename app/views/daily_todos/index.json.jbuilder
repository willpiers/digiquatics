json.array!(@daily_todos) do |daily_todo|
  json.extract! daily_todo, :id, :name, :type, :status
  json.url daily_todo_url(daily_todo, format: :json)
end
