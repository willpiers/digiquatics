@digiquatics.factory 'MyTimeOff', ['$resource',
  ($resource) ->
    $resource('/my_time_off_requests.json', {}, { index: { method: 'GET', isArray: true}})
]
