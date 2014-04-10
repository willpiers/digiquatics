@digiquatics.controller 'PrivateLessonsCtrl', ['$scope', 'Lessons',
  @UsersCtrl = ($scope, Lessons) ->
    $scope.predicate =
      value: 'last_name'

    Lessons.index (data) ->
      $scope.lessons = data
]
