@digiquatics.factory 'Shifts', ['$resource',
  ($resource) ->
    $resource('/shifts.json', {}, { index: { method: 'GET', isArray: true}})
]
