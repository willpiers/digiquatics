@digiquatics.controller 'LocationsCtrl', [
  '$scope'
  'Locations'
  'Users'
  @LocationsCtrl = ($scope, Locations, Users) ->
    $scope.locations = Locations.index()
    $scope.users = Users.index()
]
