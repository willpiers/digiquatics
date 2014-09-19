@digiquatics.controller 'MySubRequestsCtrl', [
  '$scope'
  'MySubRequests'
  'Users'
  'Locations'
  'Positions'

  @MySubRequestsCtrl = ($scope, MySubRequests, Users, Locations, Positions) ->
    # Services
    $scope.mySubRequests = MySubRequests.index()
    $scope.locations = Locations.index()

    # Other
    $scope.predicate =
      value: '-shift.start_time'

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.cssClass = (request) ->
      if request.approved is true then 'success'
      else if request.approved is false then 'danger'
      else 'warning'

    $scope.checkActive = (request) ->
      if request.active == false then false
      else true
]
