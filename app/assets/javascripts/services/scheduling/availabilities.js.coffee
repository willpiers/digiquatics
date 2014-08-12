@digiquatics.factory 'Availabilities', [
  '$resource'
  ($resource) ->
    $resource('/availabilities/:id.json', null,
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
