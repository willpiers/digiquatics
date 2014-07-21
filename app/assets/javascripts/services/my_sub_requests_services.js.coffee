@digiquatics.factory 'MySubRequests', ['$resource',
  ($resource) ->
    $resource('/my_sub_requests.json', {}, { index: { method: 'GET', isArray: true}})
]
