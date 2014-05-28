@digiquatics.factory 'CompletedAdminPrivateLessons', ['$resource',
  ($resource) ->
    $resource('/completed_admin_index.json', {}, { index: { method: 'GET', isArray: true}})
]

