@digiquatics.factory 'SubRequests', [
  '$resource'
  ($resource) ->
    $resource('/sub_requests/:id.json', {id: '@id'},
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
