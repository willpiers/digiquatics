@digiquatics.controller 'UsersCtrl', ['$scope', 'Users',
  @UsersCtrl = ($scope, Users) ->
    $scope.predicate =
      value: 'last_name'

    $scope.users = Users.index()
]
