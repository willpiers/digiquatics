@digiquatics.factory 'Availabilities', [
  '$resource'
  ($resource) ->
    $resource('/availabilities/:id.json', {id: '@id'},
      index:
        method: 'GET'
        isArray: true

      update:
        method: 'PUT'

      create:
        method: 'POST'

      destroy:
        method: 'DELETE'
    )
]
