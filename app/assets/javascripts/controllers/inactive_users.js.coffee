@digiquatics.controller 'InactiveUsersCtrl', ['$scope', 'InactiveUsers',
  @InactiveUsersCtrl = ($scope, InactiveUsers) ->
    $scope.sorter =
      value: 'last_name'

    $scope.inactive_users = InactiveUsers.inactive_index()
]
