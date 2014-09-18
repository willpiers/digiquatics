@digiquatics.controller 'ArchivedTimeOffCtrl', [
  '$scope'
  'ArchivedTimeOff'
  'Users'
  'Locations'
  'Positions'
  'TimeOffHelper'
  @ArchivedTimeOffCtrl = ($scope, ArchivedTimeOff, Users, Locations, Positions,
                          TimeOffHelper) ->
    angular.extend $scope, TimeOffHelper
    # Services
    $scope.archivedTimeOff = ArchivedTimeOff.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Other
    $scope.predicate =
      value: 'last_name'

    $scope.cssClass = (request) ->
      if request.approved then 'success' else 'danger'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.checkIfProcessed = (request) ->
      !request.active
]
