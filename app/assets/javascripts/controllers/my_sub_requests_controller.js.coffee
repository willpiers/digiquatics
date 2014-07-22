@digiquatics.controller 'MySubRequestsCtrl', ['$scope', 'MySubRequests', 'Users',
                                                     'Locations', 'Positions',
  @UsersCtrl = ($scope, MySubRequests, Users, Locations, Positions) ->
    # Services
    $scope.mySubRequests = MySubRequests.index()
    $scope.locations = Locations.index()

    # Other
    $scope.predicate =
      value: 'starts_at'

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.cssClass = (request) ->
      if request.approved == true && request.active == false then 'success'
      else if request.approved == false && request.active == false then 'danger'
      else 'warning'

    $scope.checkActive = (request) ->
      if request.active == false then false
      else true
]
