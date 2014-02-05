@digiquatics.factory 'InactiveUsers', ['$resource',
  ($resource) ->
    $resource('/inactive_index.json', {}, { inactive_index: { method: 'GET', isArray: true}})
]
