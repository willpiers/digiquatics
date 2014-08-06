@digiquatics.factory 'ShiftReports', ['$resource',
  ($resource) ->
    $resource('/shift_reports.json', {}, { index: { method: 'GET', isArray: true}})
]
