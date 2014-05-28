@digiquatics.controller 'CompletedAdminPrivateLessonsCtrl', ['$scope', 'CompletedAdminPrivateLessons',
                                             'Locations'
  @AdminPrivateLessonsCtrl = ($scope, CompletedAdminPrivateLessons, Locations) ->
      $scope.completedAdminPrivateLessons = CompletedAdminPrivateLessons.index()

      $scope.locations = Locations.index()

      $scope.predicate =
        value: 'created_at'
]
