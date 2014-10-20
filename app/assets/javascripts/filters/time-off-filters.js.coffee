@digiquaticsFilters.filter 'booleanToWordsTimeOff', ->
  (input) ->
    if input.approved
      'Approved'
    else if !input.active and !input.approved
      'Denied'
    else
      'Pending'
