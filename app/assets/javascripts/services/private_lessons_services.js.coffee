@digiquatics.factory 'Lessons', ['$resource',
  ($resource) ->
    $resource('/accounts/@id/private_lessons.json', {id: '@id'},
      index:
        method: 'GET'
        isArray: true
      )
]
