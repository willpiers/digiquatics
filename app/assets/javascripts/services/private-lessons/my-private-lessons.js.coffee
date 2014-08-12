@digiquatics.factory 'MyPrivateLessons', ['$resource',
  ($resource) ->
    $resource('/my_lessons.json', {}, { index: { method: 'GET', isArray: true}})
]

