@digiquatics.factory 'Shifts', [
  '$resource'
  ($resource) ->
    $resource('/shifts/:id.json', {id: '@id'},
      index:
        method: 'GET'
        isArray: true

      update:
        method: 'PUT'

      create:
        method: 'POST'
        isArray: true
    )
]
