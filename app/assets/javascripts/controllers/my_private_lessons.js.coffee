@digiquatics.controller 'MyPrivateLessonsCtrl', ['$scope', 'MyPrivateLessons',
                                             'Locations'
  @AdminPrivateLessonsCtrl = ($scope, MyPrivateLessons, Locations) ->
      $scope.myPrivateLessons = MyPrivateLessons.index()

      $scope.locations = Locations.index()

      $scope.predicate =
        value: 'last_name'
]
