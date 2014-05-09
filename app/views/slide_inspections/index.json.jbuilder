json.array!(@slide_inspections) do |slide_inspection|
  json.extract! slide_inspection, *SlideInspection.column_names

  json.slide do
    json.id          slide_inspection.slide.id
    json.name        slide_inspection.slide.name
  end

  json.user do
    json.id          slide_inspection.user.id
    json.first_name  slide_inspection.user.first_name
    json.last_name   slide_inspection.user.last_name
  end

  json.url slide_inspection_url(slide_inspection)
end
