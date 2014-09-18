@digiquatics.factory 'HelpDesks', ['$resource',
  ($resource) ->
    $resource('/help_desks.json', {}, { index: { method: 'GET', isArray: true}})
]
