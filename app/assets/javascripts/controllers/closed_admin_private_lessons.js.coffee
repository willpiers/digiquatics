@digiquatics.controller 'ClosedAdminPrivateLessonsCtrl', ['$scope', 'ClosedAdminPrivateLessons',
                                             'Locations'
  @AdminPrivateLessonsCtrl = ($scope, ClosedAdminPrivateLessons, Locations) ->
      $scope.closedAdminPrivateLessons = ClosedAdminPrivateLessons.index()

      $scope.locations = Locations.index()

      $scope.predicate =
        value: 'created_at'
]
