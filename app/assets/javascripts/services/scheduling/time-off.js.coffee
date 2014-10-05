@digiquatics.factory 'TimeOff', [
  '$resource'
  ($resource) ->
    $resource('/time_off_requests/:id.json', {id: '@id'},
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
