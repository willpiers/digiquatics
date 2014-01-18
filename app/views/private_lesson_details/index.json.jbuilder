json.array!(@private_lesson_details) do |private_lesson_detail|
  json.extract! private_lesson_detail, :id
  json.url private_lesson_detail_url(private_lesson_detail, format: :json)
end
