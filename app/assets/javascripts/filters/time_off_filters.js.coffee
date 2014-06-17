@digiquaticsFilters.filter 'booleanToWordsTimeOff', ->
  (input) ->
    if input then 'Approved' else 'Denied'
