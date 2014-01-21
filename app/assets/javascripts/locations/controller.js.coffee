@aquaticsApp.controller 'LocationsCtrl', ['$scope', 'Locations', 'Users',
  @LocationsCtrl = ($scope, Locations, Users) ->
    Locations.get (data) ->
      $scope.locations = data

    Users.get (data) ->
      $scope.users = data
]
