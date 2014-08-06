@digiquatics.factory 'ArchivedTimeOff', ['$resource',
  ($resource) ->
    $resource('/archived_time_off_requests.json', {}, { index: { method: 'GET', isArray: true}})
]
