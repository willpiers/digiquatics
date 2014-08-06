@digiquaticsFilters.filter 'formatTime', ->
  (input) ->
    d = new Date(input)
    "#{d.toLocaleTimeString()} - #{d.toLocaleDateString()}"
