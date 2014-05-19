@digiquatics.controller 'UsersCtrl', ['$scope', 'Users', 'Locations'
  @UsersCtrl = ($scope, Users, Locations) ->
    $scope.users = Users.index()
    $scope.locations = Locations.index()
]
