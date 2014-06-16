@digiquatics.controller 'TimeOffCtrl', ['$scope', 'TimeOff', 'Users',
                                       'Locations', 'Positions',
  @UsersCtrl = ($scope, TimeOff, Users, Locations, Positions) ->
    # Services
    $scope.timeOff = TimeOff.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Other
    $scope.predicate =
      value: 'last_name'
]
