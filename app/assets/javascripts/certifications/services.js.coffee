@aquaticsApp.factory 'Certs', ['$resource', @Certs = ($resource) ->
  $resource '/certification_expirations.json'
]
