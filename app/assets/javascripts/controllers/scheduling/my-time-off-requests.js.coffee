@digiquatics.controller 'MyTimeOffCtrl', [
  '$scope'
  'MyTimeOff'
  'Users'
  'Locations'
  'Positions'
  'TimeOffHelper'
  @MyTimeOffCtrl = ($scope, MyTimeOff, Users, Locations, Positions, TimeOffHelper) ->
    angular.extend $scope, TimeOffHelper
    # Services
    $scope.myTimeOff = MyTimeOff.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Other
    $scope.predicate =
      value: 'last_name'

    $scope.cssClass = (request) ->
      if request.approved and !request.active then 'success'
      else if !request.approved and !request.active then 'danger'
      else 'warning'

    $scope.checkActive = (request) ->
      request.active
]
