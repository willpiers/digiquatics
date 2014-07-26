@digiquatics.factory 'Shifts', [
  '$resource'
  ($resource) ->
    $resource('/shifts/:id.json', null,
      index:
        method: 'GET'
        isArray: true

      update:
        method: 'PUT'

      create:
        method: 'POST'
    )
]
