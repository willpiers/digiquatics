@digiquatics.controller 'InactiveUsersCtrl', ['$scope', 'InactiveUsers',
  @InactiveUsersCtrl = ($scope, InactiveUsers) ->
    $scope.predicate =
      value: 'last_name'

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.inactive_users = InactiveUsers.inactive_index()
]
