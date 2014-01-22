@digiquatics.factory 'Locations', ['$resource',
  ($resource) ->
    $resource('/locations.json', {}, { index: { method: 'GET', isArray: true}})
]
