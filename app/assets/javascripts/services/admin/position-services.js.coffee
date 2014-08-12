@digiquatics.factory 'Positions', ['$resource',
  ($resource) ->
    $resource('/positions.json', {}, { index: { method: 'GET', isArray: true}})
]
