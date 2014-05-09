@digiquatics.controller 'UsersCtrl', ['$scope', 'Users',
  @UsersCtrl = ($scope, Users) ->
    $scope.predicate =
      value: 'last_name'

    $scope.userAdmin = (user) ->
      user.admin == true

    $scope.users = Users.index()

]
