@digiquatics.factory 'SlideInspections', ['$resource',
  ($resource) ->
    $resource('/slide_inspections.json', {}, { index: { method: 'GET', isArray: true}})
]
