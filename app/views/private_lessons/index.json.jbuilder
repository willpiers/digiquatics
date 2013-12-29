json.array!(@private_lessons) do |private_lesson|
  json.extract! private_lesson, :first_name, :email
  json.url private_lesson_url(private_lesson, format: :json)
end
