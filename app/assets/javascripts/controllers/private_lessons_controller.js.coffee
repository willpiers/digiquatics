@digiquatics.controller 'PrivateLessonsCtrl', ['$scope', 'Lessons',
  @PrivateLessonsCtrl = ($scope, Lessons) ->
    $scope.predicate =
      value: 'last_name'

    Lessons.index (data) ->
      $scope.lessons = data
]
