@digiquatics.factory 'CertificationNames', ['$resource',
  ($resource) ->
    $resource('/certification_names.json', {}, { index: { method: 'GET', isArray: true}})
]
