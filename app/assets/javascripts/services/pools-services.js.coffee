@digiquatics.factory 'Pools', ['$resource',
  ($resource) ->
    $resource('/pools.json', {}, { index: { method: 'GET', isArray: true}})
]
