@digiquaticsFilters.filter 'booleanToWordsTimeOff', ->
  (input) ->
    if input.approved then 'Approved'
    else if !input.active and !input.approved then 'Denied' else 'Pending'
