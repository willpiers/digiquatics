@aquaticsApp.factory 'Locations', ['$resource', @Locations = ($resource) ->
  $resource('/locations.json', {}, { get: { method: 'GET', isArray: true}})
]
