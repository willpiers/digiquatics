@digiquatics.factory 'TimeOff', ['$resource',
  ($resource) ->
    $resource('/time_off_requests.json', {}, { index: { method: 'GET', isArray: true}})
]
