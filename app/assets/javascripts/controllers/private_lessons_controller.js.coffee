@digiquatics.controller 'PrivateLessonsCtrl', ['$scope', 'PrivateLessons',
                                             'Locations'
  @PrivateLessonsCtrl = ($scope, PrivateLessons, Locations) ->
      $scope.privateLessons = PrivateLessons.index()

      $scope.locations = Locations.index()

      $scope.predicate =
        value: 'created_at'
]
