@digiquatics.factory 'AdminPrivateLessons', ['$resource',
  ($resource) ->
    $resource('/admin_index.json', {}, { index: { method: 'GET', isArray: true}})
]

