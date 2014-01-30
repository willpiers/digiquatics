@digiquatics.controller 'UsersCtrl', ['$scope', 'Users',
  @UsersCtrl = ($scope, Users) ->
    $scope.sorter =
      value: 'last_name'

    $scope.users = Users.index()
]
