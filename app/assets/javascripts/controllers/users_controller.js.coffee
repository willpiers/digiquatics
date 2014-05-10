@digiquatics.controller 'UsersCtrl', ['$scope', 'Users', 'Locations'
  @UsersCtrl = ($scope, Users, Locations) ->
    $scope.predicate =
      value: 'last_name'

    $scope.users = Users.index()
    $scope.locations = Locations.index()
]
