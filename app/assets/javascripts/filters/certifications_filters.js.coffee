@digiquaticsFilters.filter 'formatDate', ->
  (input) ->
    d = new Date(input)

    curr_month = d.getMonth() + 1
    curr_date = d.getDate()
    curr_year = d.getFullYear()

    "#{curr_month}/#{curr_date}/#{curr_year}"
