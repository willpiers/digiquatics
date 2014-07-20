@digiquatics.controller 'SubRequestsCtrl', ['$scope', 'SubRequests', 'Users',
                                            'Locations', 'Positions',
  @UsersCtrl = ($scope, SubRequests, Users, Locations, Positions) ->
    # Services
    $scope.subRequests = SubRequests.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Other
    $scope.predicate =
      value: 'last_name'

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true
]
