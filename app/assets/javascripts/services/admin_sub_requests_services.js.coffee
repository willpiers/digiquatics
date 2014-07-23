@digiquatics.factory 'AdminSubRequests', [
  '$resource'
  ($resource) ->
    $resource('/admin_sub_requests/:id.json', {id: '@id'},
      index:
        method: 'GET'
        isArray: true

      update:
        method: 'PUT'

      create:
        method: 'POST'
    )
]
