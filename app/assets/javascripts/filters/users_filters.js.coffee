@digiquaticsFilters.filter 'age', ->
  (input) ->
    today = new Date()
    birthDate = new Date(input)

    age = today.getFullYear() - birthDate.getFullYear()
    m = today.getMonth() - birthDate.getMonth()

    age-- if m < 0 or (m is 0 and today.getDate() < birthDate.getDate())

    age

.filter 'booleanToWords', ->
  (input) ->
    if input then 'Yes' else 'No'
