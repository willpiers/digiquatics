json.array!(@private_lessons) do |private_lesson|
  json.extract! private_lesson, *PrivateLesson.column_names

  json.url private_lesson_url(private_lesson)
end
