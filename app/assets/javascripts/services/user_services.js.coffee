@aquaticsApp.factory 'Users', ['$resource', @Users = ($resource) ->
  $resource('/users.json', {}, { get: { method: 'GET', isArray: true}})
]
