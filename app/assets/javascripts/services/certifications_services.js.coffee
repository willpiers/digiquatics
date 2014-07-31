@digiquatics.factory 'Certifications', ['$resource',
  ($resource) ->
    $resource('/certifications.json', {}, { index: { method: 'GET', isArray: true}})
]
