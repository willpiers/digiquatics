@digiquaticsFilters.filter 'booleanToWordsTimeOff', ->
  (input) ->
    if input then 'Approved' else 'Denied'

@digiquaticsFilters.filter 'timeOffFilter', ->
  (time_off, day) ->
    time_off.dayIndices.length && time_off.dayIndices.indexOf(days.indexOf(day)) > -1

