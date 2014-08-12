@digiquatics.factory 'MyShifts', ['$resource',
  ($resource) ->
    $resource('/my_schedule.json', {}, { index: { method: 'GET', isArray: true}})
]
