@digiquatics.factory 'ClosedHelpDesks', ['$resource',
  ($resource) ->
    $resource('/closed_index.json', {}, { index: { method: 'GET', isArray: true}})
]
