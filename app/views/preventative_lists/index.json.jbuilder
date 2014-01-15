json.array!(@preventative_lists) do |preventative_list|
  json.extract! preventative_list, :id, :name, :type
  json.url preventative_list_url(preventative_list, format: :json)
end
