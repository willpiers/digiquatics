@digiquatics.factory 'ClosedAdminPrivateLessons', ['$resource',
  ($resource) ->
    $resource('/closed_admin_index.json', {}, { index: { method: 'GET', isArray: true}})
]

