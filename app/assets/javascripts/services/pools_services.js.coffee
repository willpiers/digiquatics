@digiquatics.factory 'Pools', ['$resource',
  ($resource) ->
    $resource('/user_pools.json', {}, { user_pools: { method: 'GET', isArray: true}})
]
