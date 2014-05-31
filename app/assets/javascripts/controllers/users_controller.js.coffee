@digiquatics.controller 'UsersCtrl', ['$scope', 'Users', 'Locations'
  @UsersCtrl = ($scope, Users, Locations) ->
    $scope.users = Users.index()
    $scope.locations = Locations.index()

    $scope.userAdmin = (user) ->
      user.admin == true

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true
]
