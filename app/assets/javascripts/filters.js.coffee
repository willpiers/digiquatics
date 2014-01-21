angular.module('aquaticsAppFilters', []).filter 'age', ->
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

.filter 'formatDate', ->
  (input) ->
    d = new Date(input)

    curr_month = d.getMonth() + 1
    curr_date = d.getDate()
    curr_year = d.getFullYear()

    "#{curr_month}/#{curr_date}/#{curr_year}"
