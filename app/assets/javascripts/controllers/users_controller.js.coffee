@digiquatics.controller 'UsersCtrl', ['$scope', 'Users',
  @UsersCtrl = ($scope, Users) ->
    $scope.sorter =
      value: 'lastName'
]
